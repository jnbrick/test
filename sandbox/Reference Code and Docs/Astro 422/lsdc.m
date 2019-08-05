%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 March 2015
%
% This function uses least squares differential correction to characterize
% an orbit at a given epoch time.
%
% Input Variables:
%
%    RawObs             Raw Observation Matrix                   (n x 11)
%
%    Epoch              Epoch Date/Time                    (Yr,Mon,D,H,M,S)
%
%    BC                 Ballistic Coefficient                    (kg/km^2)
%
%    Tolerance          Acceptable error level before            (none)
%                       iteration ends.
%
%    report_flag        Output report flag; yes = 1              (0 or 1)
%
% Output Variables:     
%
%    X                 State vector; Position and Velocity        (km;
%                                                                  km;
%                                                                  km;
%                                                                  km/s;
%                                                                  km/s;
%                                                                  km/s)
%
% Usage  
%   
%   lsdc(RawObs,Epoch,BC)
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X] = lsdc(RawObs,Epoch,BC,tolerance,report_flag)
tic
%Call Globals

wgs84data
global MU

%Refine Input Data

[LatLonAlt Sigma Jd Yobs W] = LSDCreadobs(RawObs);
epochJd = julianday(Epoch(1),Epoch(2),Epoch(3),Epoch(4),Epoch(5),Epoch(6));
SizeRaw = size(RawObs);
n = SizeRaw(1);
RMSnew = 0.1; %Arbitrary Value; Picked zero 
t_error = 15;
counter = 0;

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
   
%Epoch R & V



[Re, Ve] = cowell(r2, v2, Jd(2), epochJd, 5, 'yynnnnnnn1', BC);

    %Save for output
    
    Xi = [Re(1); Re(2); Re(3); Ve(1); Ve(2); Ve(3)]

%Main Loop
while t_error > tolerance;

    %First Obs (i=1) Data

    [R1, V1] = cowell(Re, Ve, epochJd, Jd(1), 5, 'yynnnnnnn1', BC)
    RV(1, [1 2 3 4 5 6]) = [R1(1) R1(2) R1(3) V1(1) V1(2) V1(3)];

    gst = gstime (Jd(1));
    lst = gst + LatLonAlt(1,2);
    lst = revcheck(lst,2*pi);
    [rs,vs] = site (LatLonAlt(1,1),LatLonAlt(1,3),lst);
    [rho,az,el]=RhoAzEl(R1,rs,LatLonAlt(1,1),lst);

    Ycalc(1,1) = rho;
    Ycalc(2,1) = az;
    Ycalc(3,1) = el;
    btilde(1,1) = Yobs(1,1) - Ycalc(1,1); %rho
    range_res(1,1) = Yobs(1,1) - Ycalc(1,1); %saved for report
    btilde(2,1) = Yobs(1,2) - Ycalc(2,1); %az
    btilde(3,1) = Yobs(1,3) - Ycalc(3,1); %el


    prxR = [Re(1) + Re(1)*10^-8; Re(2); Re(3)];
    pryR = [Re(1); Re(2) + Re(2)*10^-8; Re(3)]; 
    przR = [Re(1); Re(2); Re(3) + Re(3)*10^-8]; 
    pvxV = [Ve(1) + Ve(1)*10^-8; Ve(2); Ve(3)];
    pvyV = [Ve(1); Ve(2) + Ve(2)*10^-8; Ve(3)];
    pvzV = [Ve(1); Ve(2); Ve(3) + Ve(3)*10^-8];
    [R, V] = cowell(prxR, Ve, epochJd, Jd(1), 5, 'yynnnnnnn1', BC);
    prxRV(1, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
    [prxrho,prxaz,prxel]=RhoAzEl(R,rs,LatLonAlt(1,1),lst);
    [R, V] = cowell(pryR, Ve, epochJd, Jd(1), 5, 'yynnnnnnn1', BC);
    pryRV(1, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
    [pryrho,pryaz,pryel]=RhoAzEl(R,rs,LatLonAlt(1,1),lst);
    [R, V] = cowell(przR, Ve, epochJd, Jd(1), 5, 'yynnnnnnn1', BC);
    przRV(1, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
    [przrho,przaz,przel]=RhoAzEl(R,rs,LatLonAlt(1,1),lst);
    [R, V] = cowell(Re, pvxV, epochJd, Jd(1), 5, 'yynnnnnnn1', BC);
    pvxRV(1, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
    [pvxrho,pvxaz,pvxel]=RhoAzEl(R,rs,LatLonAlt(1,1),lst);
    [R, V] = cowell(Re, pvyV, epochJd, Jd(1), 5, 'yynnnnnnn1', BC);
    pvyRV(1, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
    [pvyrho,pvyaz,pvyel]=RhoAzEl(R,rs,LatLonAlt(1,1),lst);
    [R, V] = cowell(Re, pvzV, epochJd, Jd(1), 5, 'yynnnnnnn1', BC);
    pvzRV(1, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
    [pvzrho,pvzaz,pvzel]=RhoAzEl(R,rs,LatLonAlt(1,1),lst);

    A(1,1) = (prxrho - rho)/(Re(1)*10^-8);
    A(1,2) = (pryrho - rho)/(Re(2)*10^-8);
    A(1,3) = (przrho - rho)/(Re(3)*10^-8);
    A(1,4) = (pvxrho - rho)/(Ve(1)*10^-8);
    A(1,5) = (pvyrho - rho)/(Ve(2)*10^-8);
    A(1,6) = (pvzrho - rho)/(Ve(3)*10^-8);

    A(2,1) = (prxaz - az)/(Re(1)*10^-8);
    A(2,2) = (pryaz - az)/(Re(2)*10^-8);
    A(2,3) = (przaz - az)/(Re(3)*10^-8);
    A(2,4) = (pvxaz - az)/(Ve(1)*10^-8);
    A(2,5) = (pvyaz - az)/(Ve(2)*10^-8);
    A(2,6) = (pvzaz - az)/(Ve(3)*10^-8);

    A(3,1) = (prxel - el)/(Re(1)*10^-8);
    A(3,2) = (pryel - el)/(Re(2)*10^-8);
    A(3,3) = (przel - el)/(Re(3)*10^-8);
    A(3,4) = (pvxel - el)/(Ve(1)*10^-8);
    A(3,5) = (pvyel - el)/(Ve(2)*10^-8);
    A(3,6) = (pvzel - el)/(Ve(3)*10^-8);




    for i = 2:n;
        %Find Site Data

        gst = gstime (Jd(i));
        lst = gst + LatLonAlt(i,2);
        lst = revcheck(lst,2*pi);
        [rs,vs] = site (LatLonAlt(i,1),LatLonAlt(i,3),lst);

        %Propagate Orbits & Build RV matrix

        [R, V] = cowell([RV(i-1,1); RV(i-1,2); RV(i-1,3)],...
            [RV(i-1,4); RV(i-1,5); RV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        RV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [rho,az,el]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        [R, V] = cowell([prxRV(i-1,1); prxRV(i-1,2); prxRV(i-1,3)],...
            [prxRV(i-1,4); prxRV(i-1,5); prxRV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        prxRV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [prxrho,prxaz,prxel]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        [R, V] = cowell([pryRV(i-1,1); pryRV(i-1,2); pryRV(i-1,3)],...
            [pryRV(i-1,4); pryRV(i-1,5); pryRV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        pryRV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [pryrho,pryaz,pryel]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        [R, V] = cowell([przRV(i-1,1); przRV(i-1,2); przRV(i-1,3)],...
            [przRV(i-1,4); przRV(i-1,5); przRV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        przRV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [przrho,przaz,przel]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        [R, V] = cowell([pvxRV(i-1,1); pvxRV(i-1,2); pvxRV(i-1,3)],...
            [pvxRV(i-1,4); pvxRV(i-1,5); pvxRV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        pvxRV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [pvxrho,pvxaz,pvxel]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        [R, V] = cowell([pvyRV(i-1,1); pvyRV(i-1,2); pvyRV(i-1,3)],...
            [pvyRV(i-1,4); pvyRV(i-1,5); pvyRV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        pvyRV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [pvyrho,pvyaz,pvyel]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        [R, V] = cowell([pvzRV(i-1,1); pvzRV(i-1,2); pvzRV(i-1,3)],...
            [pvzRV(i-1,4); pvzRV(i-1,5); pvzRV(i-1,6)],...
            Jd(i-1), Jd(i), 5, 'yynnnnnnn1', BC);
        pvzRV(i, [1 2 3 4 5 6]) = [R(1) R(2) R(3) V(1) V(2) V(3)];
        [pvzrho,pvzaz,pvzel]=RhoAzEl(R,rs,LatLonAlt(i,1),lst);

        %Produce Ycalc

        Ycalc(i*3-2,1) = rho;
        Ycalc(i*3-1,1) = az;
        Ycalc(i*3,1) = el;

        %Produce Residuals, btilde

        btilde(i*3-2,1) = Yobs(i,1) - Ycalc(i*3-2,1); %rho
        range_res(i,1) = Yobs(i,1) - Ycalc(i*3-2,1); %saved for report
        btilde(i*3-1,1) = Yobs(i,2) - Ycalc(i*3-1,1); %az
        btilde(i*3,1) = Yobs(i,3) - Ycalc(i*3,1); %el

        %Construct A

        A(i*3-2,1) = (prxrho - rho)/(Re(1)*10^-8);
        A(i*3-2,2) = (pryrho - rho)/(Re(2)*10^-8);
        A(i*3-2,3) = (przrho - rho)/(Re(3)*10^-8);
        A(i*3-2,4) = (pvxrho - rho)/(Ve(1)*10^-8);
        A(i*3-2,5) = (pvyrho - rho)/(Ve(2)*10^-8);
        A(i*3-2,6) = (pvzrho - rho)/(Ve(3)*10^-8);

        A(i*3-1,1) = (prxaz - az)/(Re(1)*10^-8);
        A(i*3-1,2) = (pryaz - az)/(Re(2)*10^-8);
        A(i*3-1,3) = (przaz - az)/(Re(3)*10^-8);
        A(i*3-1,4) = (pvxaz - az)/(Ve(1)*10^-8);
        A(i*3-1,5) = (pvyaz - az)/(Ve(2)*10^-8);
        A(i*3-1,6) = (pvzaz - az)/(Ve(3)*10^-8);

        A(i*3,1) = (prxel - el)/(Re(1)*10^-8);
        A(i*3,2) = (pryel - el)/(Re(2)*10^-8);
        A(i*3,3) = (przel - el)/(Re(3)*10^-8);
        A(i*3,4) = (pvxel - el)/(Ve(1)*10^-8);
        A(i*3,5) = (pvyel - el)/(Ve(2)*10^-8);
        A(i*3,6) = (pvzel - el)/(Ve(3)*10^-8);

    end

    %Solve for dX
    dX = inv(A'*W*A)*A'*W*btilde;
    
    %Save Covariance Matrix
    
    covariance = inv(A'*W*A);
    
    %Update State
    
    Re = [Re(1) + dX(1); Re(2) + dX(2); Re(3) + dX(3)];
    Ve = [Ve(1) + dX(4); Ve(2) + dX(5); Ve(3) + dX(6)];
    
    %update misc info
    RMSold = RMSnew;
    RMSnew = (btilde'*W*btilde)/n;
    counter = counter+1;
    t_error = abs((RMSnew-RMSold)/RMSold);
    
        %Report output:
        if report_flag == 1;
            X = [Re(1) + dX(1); Re(2) + dX(2); Re(3) + dX(3);Ve(1) + dX(4);...
            Ve(2) + dX(5); Ve(3) + dX(6)];
            lsdc_report(Xi, X, epochJd, t_error, counter, A, btilde,covariance);
            hold on
            cmap = hsv(9);
            plot((Jd-Jd(1))*86400,range_res,'color',cmap(counter,:),'MarkerEdgeColor','k',...
                'Marker','*');
            xlabel('Time Since First Obs (Seconds)')
            ylabel('Residual Range Error (km)')
            legend('Iteration 1','Iteration 2',...
                'Iteration 3','Iteration 4','Iteration 5','Iteration 6',...
                'Iteration 7','Iteration 8','Iteration 9','Location','eastoutside')
            disp('Paused Iteration')
            disp(counter)
            %pause
        end
            
    
end

%Define state vector

X = [Re(1) + dX(1); Re(2) + dX(2); Re(3) + dX(3);Ve(1) + dX(4);...
    Ve(2) + dX(5); Ve(3) + dX(6)];

%Report



toc