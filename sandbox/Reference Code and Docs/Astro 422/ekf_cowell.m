%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 March 2015
%
% This function uses and extended Kalman filter to characterize an orbit 
% at a given epoch time.
%
% Input Variables:
%
%    RawObs             Raw Observation Matrix                   (n x 11)
%
%    Epoch              Epoch Date/Time                    (Yr,Mon,D,H,M,S)
%
%    BC                 Ballistic Coefficient                    (kg/km^2)
%
%    Q                  Smug Prevention Matrix (Name?)           (n x n)
%
%    report_flag        Output report flag; yes = 1              (0 or 1)
%
% Output Variables:     
%
%    Xh                State vector; Position and Velocity        (km;
%                                                                  km;
%                                                                  km;
%                                                                  km/s;
%                                                                  km/s;
%                                                                  km/s)
%
% Usage  
%   
%   ekf_cowell(RawObs,Epoch,BC)
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Xh] = ekf_cowell(RawObs,Epoch,BC,Q,report_flag)

%Call Globals

wgs84data
global MU

%Refine Input Data

[LatLonAlt Sigma Jd Yobs W] = LSDCreadobs(RawObs);
SizeRaw = size(RawObs);
n = SizeRaw(1);
epochJd = julianday(Epoch(1),Epoch(2),Epoch(3),Epoch(4),Epoch(5),Epoch(6));
counter = 1;

%Initial Estimate (R2 V2)

    %R1
    
    gst1 = gstime (Jd(1));
    lst1 = gst1 + LatLonAlt(1,2);
    lst1 = revcheck(lst1,2*pi);
    [rs1,vs1] = site (LatLonAlt(1,1),LatLonAlt(1,3),lst1);
    r1 = track (Yobs(1,1),Yobs(1,2),Yobs(1,3),0,0,0,LatLonAlt(1,1),lst1, rs1);

    %R2
    
    gst2 = gstime (Jd(2));
    lst2 = gst2 + LatLonAlt(2,2);
    lst2 = revcheck(lst2,2*pi);
    [rs2,vs2] = site (LatLonAlt(2,1),LatLonAlt(2,3),lst2);
    r2 = track (Yobs(2,1),Yobs(2,2),Yobs(2,3),0,0,0,LatLonAlt(2,1),lst2, rs2);
       
    %R3

    gst3 = gstime (Jd(3));
    lst3 = gst3 + LatLonAlt(3,2);
    lst3 = revcheck(lst3,2*pi);
    [rs3,vs3] = site (LatLonAlt(3,1),LatLonAlt(3,3),lst3);
    r3 = track (Yobs(3,1),Yobs(3,2),Yobs(3,3),0,0,0,LatLonAlt(3,1),lst3, rs3);
    
    %V2
    
    v2 = herrgibbs (r1,r2,r3,Jd(1),Jd(2),Jd(3));

%Propogate to Epoch (Cowell)

[Re, Ve] = cowell(r2, v2, Jd(2), epochJd, 5, 'yynnnnnnn1', BC);

    %Save for output
    
    Xi = [Re(1); Re(2); Re(3); Ve(1); Ve(2); Ve(3)];


%Establish Nominals
        
    %Nominal State

    Xh([1 2 3 4 5 6],1) = [Re(1) Re(2) Re(3) Ve(1) Ve(2) Ve(3)];

    %Nominal State Correction

    dXh = [0;0;0;0;0;0];

    %Predict Covariance

    Ph = eye(6)*9E5;
        
%Main Loop

while counter < n+1; 

    %Find Site Data
        
    gst = gstime (Jd(counter));
    lst = gst + LatLonAlt(counter,2);
    lst = revcheck(lst,2*pi);
    [rs,vs] = site (LatLonAlt(counter,1),LatLonAlt(counter,3),lst);    
    
    
    %State Transition Matrix
    
    if counter == 1
        dt = (Jd(counter)-epochJd)*86400;
    else
        dt = (Jd(counter)-Jd(counter-1))*86400;
    end  
    
    dadr_coeff = 3*MU*mag(Xh)^(-5);
    dadr_bias = -MU*mag(Xh)^(-3);
    dadr = [Xh(1)^2     Xh(1)*Xh(2) Xh(1)*Xh(3);...
            Xh(1)*Xh(2) Xh(2)^2     Xh(2)*Xh(3);...
            Xh(1)*Xh(3) Xh(2)*Xh(3) Xh(3)^2]...
         *dadr_coeff + eye(3)*dadr_bias;

    Phi = eye(6) + [zeros(3) eye(3); dadr zeros(3)]*dt;
    
    %PREDICT
    
        %Predict State
        
        if counter == 1
            [R, V] = cowell(Xh(1:3), Xh(4:6), epochJd, Jd(counter),...
                5, 'yynnnnnnn1', BC);
        else
            [R, V] = cowell(Xh(1:3), Xh(4:6), Jd(counter-1), Jd(counter),...
                5, 'yynnnnnnn1', BC);
        end
        
        Xb = [R;V];
        Xbhist(counter, [1 2 3 4 5 6]) = Xb([1 2 3 4 5 6], 1); %Save Xbar
        
        
        %Predict Covariance
        
        if Q == 0;
           Pb = Phi*Ph*Phi';
        else
           Pb = Phi*Ph*Phi'+Q;
        end
                
    %CORRECT
            
        %Caluclate Residuals
            
        [rho_c,az_c,el_c]=RhoAzEl(Xb(1:3),rs,LatLonAlt(counter,1),lst);
        Ycalchist(counter,[1 2 3]) = [rho_c az_c el_c]; %Save Ycalc
        
        
        btilde = [Yobs(counter,1)-rho_c;Yobs(counter,2)-az_c;...
                  Yobs(counter,3)-el_c];
        btilhist(counter,[1 2 3]) = btilde; %Save B tilde
        
        %Build H
       
        [prhodrx, pazdrx, peldrx] = RhoAzEl(Xb(1:3) + [Xb(1)*10E-8;0;0],...
                                    rs,LatLonAlt(counter,1),lst);
        drhodrx = (prhodrx - rho_c)/(Xb(1)*10E-8);
        dazdrx = (pazdrx - az_c)/(Xb(1)*10E-8);
        deldrx = (peldrx - el_c)/(Xb(1)*10E-8);
        [prhodry, pazdry, peldry] = RhoAzEl(Xb(1:3) + [0;Xb(2)*10E-8;0],...
                                    rs,LatLonAlt(counter,1),lst);
        drhodry = (prhodry - rho_c)/(Xb(2)*10E-8);
        dazdry = (pazdry - az_c)/(Xb(2)*10E-8);
        deldry = (peldry - el_c)/(Xb(2)*10E-8);
        [prhodrz, pazdrz, peldrz] = RhoAzEl(Xb(1:3) + [0;0;Xb(3)*10E-8],...
                                    rs,LatLonAlt(counter,1),lst);
        drhodrz = (prhodrz - rho_c)/(Xb(3)*10E-8);
        dazdrz = (pazdrz - az_c)/(Xb(3)*10E-8);
        deldrz = (peldrz - el_c)/(Xb(3)*10E-8);
        
        H = [drhodrx, drhodry, drhodrz, 0, 0, 0;...
             dazdrx,  dazdry,  dazdrz,  0, 0, 0;...
             deldrx,  deldry,  deldrz,  0, 0, 0];
        
        %Compute Kalman Gain
        
        w = [W(counter*3-2,counter*3-2), 0 , 0; ...
              0, W(counter*3-1,counter*3-1), 0;...
              0, 0, W(counter*3,counter*3)];
          
        k = Pb*H'*inv(H*Pb*H' + inv(w));
        
     
        %Correct State Correction
        
        dXh = k*(btilde);
        dXhhist(counter, [1 2 3 4 5 6]) = dXh(1:6); %Save dXhat
        
        %Correct Covariance
        
        Ph = (eye(6) - k*H)*Pb;
        
        %Correct State
        
        Xh = Xb + dXh; 
        Xhhist(counter, [1 2 3 4 5 6]) = Xh([1 2 3 4 5 6],1); %Save Xhat
        
        %Reset dXhat
        
        dXh = zeros(6,1);
        
        %Update Counter
        
        counter = counter+1;
end

%Backwards Propagation for Epoch Analysis

    %State
    
    [Ref, Vef] = cowell(Xh(1:3), Xh(4:6), Jd(end), epochJd, 5, 'yynnnnnnn1', BC);

    Xf = [Ref;Vef];

    %Covariance Matrix

        %State Transition Matrix

        dt = (epochJd - Jd(end))*86400;

        dadr_coeff = 3*MU*mag(Xh)^(-5);
        dadr_bias = -MU*mag(Xh)^(-3);
        dadr = [Xh(1)^2     Xh(1)*Xh(2) Xh(1)*Xh(3);...
                Xh(1)*Xh(2) Xh(2)^2     Xh(2)*Xh(3);...
                Xh(1)*Xh(3) Xh(2)*Xh(3) Xh(3)^2]...
             *dadr_coeff + eye(3)*dadr_bias;

        Phi = eye(6) + [zeros(3) eye(3); dadr zeros(3)]*dt;
    
        %Predict Covariance
        
        if Q == 0;
           Pe = Phi*Ph*Phi';
        else
           Pe = Phi*Ph*Phi'+Q;
        end
    
%Output Report

if report_flag == 1;
    
    ekf_report(Xi, Xf, epochJd, Pe);
    
    plot((Jd-Jd(1))*86400,btilhist(:,1),'k')
    xlabel('Time Since First Obs (Seconds)')
    ylabel('Residual Range Error (km)')
    
    Average_Residual = sum(abs(btilhist(12:end,1)))/17
end

        
    