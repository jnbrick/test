%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                       Program RhoAzEl
%
% [rho,az,el]=RhoAzEl(R_ijk,R_site,sitlat,lst)
%
% This procedure determines topocentric range, azimuth, and elevation 
% from the site vector and the satellite position vector.
%
%   Author       : C2C Richard Phernetton, USAFA, Fall 2013
%
%   Input        :
%   R_ijk		S/C ECI position vector             km
%	R_site		Site ECI position vector            km
%	sitlat		Site geodetic latitude              rad
%	lst         Site local sidereal time            rad
%	jd          Julian Date at viewing time		
%
%   Outputs       :
%   rho         	Range           km
%	az              Azimuth         rad
%	el              Elevation		rad	
%
%
%   Locals       :
%
%   Constants:
%
%   Coupling:
%
%   References   : None.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rho,az,el]=RhoAzEl(R_ijk,R_site,sitlat,lst)

%Find Rho_sez
   
Rho_ijk = R_ijk-R_site;
    
Rho_1st = axisrot(Rho_ijk, 3, lst);
Rho_sez = axisrot(Rho_1st, 2, pi/2-sitlat);

%Find rho

rho = mag(Rho_ijk);

%Find el

el = asin(Rho_sez(3)/rho);

%Find az

az = revcheck(atan2(Rho_sez(2),-Rho_sez(1)),2*pi);
