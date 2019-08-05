%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 8 January 2015
%
% This function converts a satellite state vector and radar tracking site 
% location to COEs, GST, LST, IJK site position vector, and range azimuth
% and elevation angles from the tracking site to the satellite, then prints
% the data to a file.
%
% Input Variables:
%   
%    R                  Satellite position vector (IJK)      (km; km; km)
%
%    V                  Satellite velocity vector (IJK)      (km; km; km)
%
%    lon                Site longitude                       (deg)
%
%    lat                Site lattitude                       (deg)
%
%    alt                Site altitude                        (deg)
%
%    DateTime           UT date and time 
%                                    (CE year, month, day, hour, min, sec)
%
% Output Variables:     
%
%    a                  Semimajor axis                       (km)
%
%    e                  Eccentricity                         (none)
%
%    inc                Inclination                          (deg)
%
%    raan               Right ascension of the ascending     (deg)
%                       node
%
%    argp               Argument of perigee                  (deg)
%
%    nu                 True anomoly                         (deg)
%
%    gst                Global sideral time                  (deg)
%
%    lst                Local sideral time                   (deg)
%
%    RS                 Site Location (IJK)                  (km; km; km)
%
%    rho                Range from site to satellite         (km)
%
%    az                 Azimuth from site to satellite       (deg)
%
%    el                 Elevation from site to satellite     (deg)
%
% Usage  
%   
%   SkillsRev(R,V,lon,lat,alt,DateTime)
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SkillsRev(R,V,lon,lat,alt,DateTime);

%Call WGS84 Data

global wgs84data

%Find COEs

[P,a,e,inc,raan,argp,nu] = elorb(R,V); 

%Find GST
    
    %Find Julian Date
    
    jd=julianday(DateTime(1),DateTime(2),DateTime(3),DateTime(4),...
       DateTime(5),DateTime(6));

gst = gstime(jd);

%Find LST

lst = gst + deg2rad(lon);

%Find RS

[RS,VS] = site(deg2rad(lat),alt,lst);

%Find Range, Azimuth, and Elevation

[rho,az,el]=RhoAzEl(R,RS,deg2rad(lat),lst);

%Output File

FID = fopen('SkillsReview.txt','w');

fprintf(FID,'ASTRO 422 \r\n');
fprintf(FID,'Skills Review \r\n');
fprintf(FID,'Richard Phernetton \r\n');

fprintf(FID,'\r\n\r\nInputs\r\n');
fprintf(FID,'**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,'Position:                 % 15.4f I km\r\n',R(1));
fprintf(FID,'                          % 15.4f J km\r\n',R(2));
fprintf(FID,'                          % 15.4f K km\r\n',R(3));
fprintf(FID,'Velocity:                 % 15.4f I km/s\r\n',V(1));
fprintf(FID,'                          % 15.4f J km/s\r\n',V(2));
fprintf(FID,'                          % 15.4f K km/s\r\n',V(3));
fprintf(FID,'Year:                     % 15.0f     \r\n',DateTime(1));
fprintf(FID,'Month:                    % 15.0f     \r\n',DateTime(2));
fprintf(FID,'Day:                      % 15.0f     \r\n',DateTime(3));
fprintf(FID,'Hour:                     % 15.0f     \r\n',DateTime(4));
fprintf(FID,'Minute:                   % 15.0f     \r\n',DateTime(5));
fprintf(FID,'Second:                   % 15.4f     \r\n',DateTime(6));
fprintf(FID,'Site Lattitude:           % 15.4f   rad\r\n',deg2rad(lat));
fprintf(FID,'                          % 15.4f   deg\r\n',lat);
fprintf(FID,'Site Longitude:           % 15.4f   rad\r\n',deg2rad(lon));
fprintf(FID,'                          % 15.4f   deg\r\n',lon);
fprintf(FID,'Site Altitude:            % 15.4f    km\r\n',alt);


fprintf(FID,'\r\n\r\nOutputs\r\n');
fprintf(FID,'**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,'Semimajor Axis:           % 15.4f   km\r\n',a);
fprintf(FID,'Inclination:              % 15.4f   rad\r\n',inc);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(inc));
fprintf(FID,'Eccentricity:             % 15.4f   \r\n',e);
fprintf(FID,'RAAN:                     % 15.4f   rad\r\n',raan);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(raan));
fprintf(FID,'Argument of Perigee:      % 15.4f   rad\r\n',argp);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(argp));
fprintf(FID,'True Anomoly:             % 15.4f   rad\r\n',nu);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(nu));
fprintf(FID,'Julian Date:              % 15.4f      \r\n',jd);
fprintf(FID,'Global Sidereal Time:     % 15.4f   rad\r\n',gst);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(gst));
fprintf(FID,'Local Sidereal Time:      % 15.4f   rad\r\n',lst);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(lst));
fprintf(FID,'Site Position:            % 15.4f I km\r\n',RS(1));
fprintf(FID,'                          % 15.4f J km\r\n',RS(2));
fprintf(FID,'                          % 15.4f K km\r\n',RS(3));
fprintf(FID,'Range (rho):              % 15.4f   km\r\n',rho);
fprintf(FID,'Azimuth:                  % 15.4f   rad\r\n',az);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(az));
fprintf(FID,'Elevation:                % 15.4f   rad\r\n',el);
fprintf(FID,'                          % 15.4f   deg\r\n',rad2deg(el));

fclose(FID);
