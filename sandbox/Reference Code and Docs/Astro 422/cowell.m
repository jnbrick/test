%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 9 February 2015
%
% This function numerically propagates an orbit with common pertubations
%
% Input Variables:
%   
%    Ri                 Satellite position vector (IJK)      (km;
%                                                             km;
%                                                             km)
%
%    Vi                 Satellite velocity vector (IJK)      (km/s;
%                                                             km/s;
%                                                             km/s)
%
%    JDstart            Initial Julian Date                  (days)
%
%    JDstop             Final Julian Date                    (days)
%
%    StepSizeMag        Unsigned Step Length                 (s)
%
%    DerivType          String containing y or n boolian     (yynynynnn1)
%                       for determining which perturbations
%                       will be used.
%                       1 - drag
%                       2 - J2
%                       3 - J3
%                       4 - J4
%                       5 - Sun 
%                       6 - Moon 
%                       7 - Solar Radiation Pressure 
%                       8,9 - Unused 
%
%    BC                 Ballistic Coefficient                (kg/km^2)
%
%
% Output Variables: 
%
%    Rf                 Satellite position vector (IJK)      (km;
%                                                             km;
%                                                             km)
%
%    Vf                 Satellite velocity vector (IJK)      (km/s;
%                                                             km/s;
%                                                             km/s)
%
% Usage  
%
%   [Rf, Vf] = cowell(Ri, Vi, JDstart, JDstop, StepSizeMag, Derivtype, BC);
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Rf, Vf] = cowell(Ri, Vi, JDstart, JDstop, StepSizeMag, Derivtype, BC);


%Call Globals

wgs84data
global MU
global OmegaEarth
    



%%
%Numerical Propagation
    
    %Set temporary values 

    if JDstart < JDstop
        timestep = StepSizeMag;   %Time step
    else
        timestep = -StepSizeMag;  %Time step
    end
    
    ttime = 0;                %Time (seconds)
    tR = Ri;                  %Position (km)
    tV = Vi;                  %Velocity (km/s)
    tof = (JDstop - JDstart)*86400;   %Time Of flight (seconds)
    tdate = JDstart;          %Date (days)

    while abs(ttime) < abs(tof);    

        %Calculate next position and velocity

        [tRtV] = rk4 ( tdate, timestep, Derivtype, BC, [tR;tV] );

        %Unpack rk4 output

        tR = tRtV(1:3);
        tV = tRtV(4:6);

        %Update tdate, ttime

        ttime = ttime + timestep;
    
    end
    
    %Cleanup

        %Calculate next position and velocity
        remtime = tof - ttime;
        
        
        [tRtV] = rk4 ( tdate, remtime,...
            Derivtype, BC, [tR;tV] );
        
        ttime = ttime + remtime;
        
        tdate = JDstart + (ttime/86400);
        cowellerror = tof - ttime;

        
        %Unpack rk4 output

        tR = tRtV(1:3);
        tV = tRtV(4:6);        

    %Unpack R, V, and time

    Rf = tR;
    Vf = tV;
    tf = ttime;

    
RI = Rf(1);



        

