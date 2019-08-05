%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 9 February 2015
%
% This function test cowell and outputs a report
%
% Input Variables:
%   
%    a                  Semimajor axis (initial)             (km)
%
%    e                  Eccentricity (initial)               (none)
%
%    inc                Inclination (initial)                (deg)
%
%    raan               Right ascension of the ascending     (deg)
%                       node (initial)
%
%    argp               Argument of perigee (initial)        (deg)
%
%    nu                 True anomoly (initial)               (deg)
%
%    DateTime           UT date and time (initial)
%                                    (CE year, month, day, hour, min, sec)
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
%    BC                 Ballistic Coefficient                (kg/m^2)
%
%    OrbitMultiplier    Number of orbits to be Propagated
%
%
% Output Variables: 
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
function cowelltest(a,e,inc, raan, argp, nu, DateTime, StepSizeMag, Derivtype, BC, OrbitMultiplier);

%Call Globals

wgs84data
global MU


%Find Initial R and V vectors
    
    %From COEs to PQW frame
    
    [Rpqw_i, Vpqw_i] = RVpqw(a, e, deg2rad(nu));
    
    %From PQW frame to IJK frame
    
    [Ri,Vi] = RVijk(Rpqw_i,Vpqw_i,...
        deg2rad(inc), deg2rad(raan), deg2rad(argp));

%Calculate Orbital Period (seconds)

per = 2*pi*sqrt(a^3/MU)   

%Set time of flight for each orbital case (seconds)

tof = per*OrbitMultiplier;   

%Find Start Julian Date (days)

JDstart = julianday(DateTime(1),DateTime(2),DateTime(3),DateTime(4),...
   DateTime(5),DateTime(6));

%Find Stop Julian Date (days)

JDstop = JDstart + tof/86400;

%Find Final Date

[Yr,Mon,D,H,M,S]=invjulianday(JDstop);

%Run Cowell

[Rf, Vf] = cowell(Ri, Vi, JDstart, JDstop, StepSizeMag, Derivtype, BC);

%Covert to COEs

[P,a_f,e_f,inc_f,raan_f,argp_f,...
    nu_f,m_f,u_f,l_f,cappi_f] = elorb (Rf,Vf);


%%
%Output
FID = fopen('CowellTest.txt','w');

fprintf(FID,'ASTRO 422 \r\n');
fprintf(FID,'Cowell \r\n');
fprintf(FID,'Richard Phernetton \r\n');

fprintf(FID,'\r\n\r\nInputs\r\n');
fprintf(FID,'**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,'Semimajor Axis:     % 12.6f   km\r\n',a);
fprintf(FID,'Inclination:        % 12.6f   rad\r\n',deg2rad(inc));
fprintf(FID,'                    % 12.6f   deg\r\n',inc);
fprintf(FID,'Eccentricity:       % 12.6f   \r\n',e);
fprintf(FID,'RAAN:               % 12.6f   rad\r\n',deg2rad(raan));
fprintf(FID,'                    % 12.6f   deg\r\n',raan);
fprintf(FID,'Argument of Perigee:% 12.6f   rad\r\n',deg2rad(argp));
fprintf(FID,'                    % 12.6f   deg\r\n',argp);
fprintf(FID,'True Anomoly:       % 12.6f   rad\r\n',deg2rad(nu));
fprintf(FID,'                    % 12.6f   deg\r\n',nu);
fprintf(FID,'Initial Position:   % 12.6f I km\r\n',Ri(1));
fprintf(FID,'                    % 12.6f J km\r\n',Ri(2));
fprintf(FID,'                    % 12.6f K km\r\n',Ri(3));
fprintf(FID,'Initial Velocity:   % 12.6f I km/s\r\n',Vi(1));
fprintf(FID,'                    % 12.6f J km/s\r\n',Vi(2));
fprintf(FID,'                    % 12.6f K km/s\r\n',Vi(3));
fprintf(FID,'Year:               % 12.0f     \r\n',DateTime(1));
fprintf(FID,'Month:              % 12.0f     \r\n',DateTime(2));
fprintf(FID,'Day:                % 12.0f     \r\n',DateTime(3));
fprintf(FID,'Hour:               % 12.0f     \r\n',DateTime(4));
fprintf(FID,'Minute:             % 12.0f     \r\n',DateTime(5));
fprintf(FID,'Second:             % 12.6f     \r\n',DateTime(6));

fprintf(FID,'\r\n\r\nPosition                   ');

fprintf(FID,'\r\n**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,...
    '                    I:% 11.6f km\r\n',...
    Rf(1));
fprintf(FID,...
    '                    J:% 11.6f km\r\n',...
    Rf(2));
fprintf(FID,...
    '                    K:% 11.6f km\r\n\r\n',...
    Rf(3));



fprintf(FID,'\r\n\r\nVelocity                   ');

fprintf(FID,'\r\n**************************************');
fprintf(FID,'*************************************\r\n');


fprintf(FID,...
    '                    I:% 11.6f km/s\r\n',...
    Vf(1));
fprintf(FID,...
    '                    J:% 11.6f km/s\r\n',...
    Vf(2));
fprintf(FID,...
    '                    K:% 11.6f km/s\r\n\r\n',...
    Vf(3));



fprintf(FID,'\r\n\r\nCOEs                       ');

fprintf(FID,'\r\n**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,...
    '                    a:% 11.6f km  \r\n',...
    (a_f));
fprintf(FID,...
    '                    e:% 11.6f     \r\n',...
    (e_f));
fprintf(FID,...
    '                    i:% 11.6f deg \r\n',...
    rad2deg(inc_f));
fprintf(FID,...
    '                 RAAN:% 11.6f deg \r\n',...
    rad2deg(raan_f));
fprintf(FID,...
    '                 ArgP:% 11.6f deg \r\n',...
    rad2deg(argp_f));
fprintf(FID,...
    '                   Nu:% 11.6f deg \r\n\r\n',...
    rad2deg(nu_f));


fprintf(FID,'\r\n\r\nFinal Date                 ');
fprintf(FID,'\r\n**************************************');
fprintf(FID,'*************************************\r\n');
fprintf(FID,'Year:               % 12.0f     \r\n',Yr);
fprintf(FID,'Month:              % 12.0f     \r\n',Mon);
fprintf(FID,'Day:                % 12.0f     \r\n',D);
fprintf(FID,'Hour:               % 12.0f     \r\n',H);
fprintf(FID,'Minute:             % 12.0f     \r\n',M);
fprintf(FID,'Second:             % 12.6f     \r\n',S);


fclose(FID);
