%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 January 2015
%
% EyasSat function testing. Takes sun sensor data and outputs a body
% centered, body fixed angle from the X positive axis.
%
% Input Variables:
%   
%    Ixp                Intensity X positive direction       (counts)
%
%    Ixn                Intensity X negative direction       (counts)
%
%    Iyp                Intensity Y positive direction       (counts)
%
%    Iyn                Intensity Y negative direction       (counts)
%
% Output Variables:     
%
% Usage  
%   
%   [angle] = ESsun2angle(Ixp, Ixn, Iyp, Iyn);
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [angle] = ESsun2angle(Ixp, Ixn, Iyp, Iyn);

% Normalize counts.

Ix = Ixp - Ixn;
Iy = Iyp - Iyn;

% Calculate Distances

xpos = sqrt(1/Ix);
ypos = sqrt(1/Iy);

% Calculate Angle

angle = rad2deg(atan2(ypos,xpos));

