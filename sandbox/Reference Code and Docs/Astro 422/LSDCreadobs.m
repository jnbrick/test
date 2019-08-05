%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 March 2015
%
% This function puts observations in matrix form, computes julian date, 
% and converts angles to radians.
%
% Input Variables:
%
%    RawObs             Raw Observation Matrix                   (n x 11)
%
% Output Variables:
%
%    LatLonEl           Latitude Longitude Elevation (rad rad km)(n x 3)
%
%    Sigma              Standard Deviation (Rho Az & El)         (n x 3)
%
%    Jd                 Julian Date Matrix                       (n x 1)
%
%    Yobs               Adjusted Observation Matrix (km rad rad) (n x 3)
%
%    W                  Weighted Matrix                          (3n x 3n)
%
% Usage  
%   
%   [Jd Obs] = LSDCreadobs(RawObs)
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [LatLonAlt Sigma Jd Yobs W] = LSDCreadobs(RawObs)

%Find n, number of observations

SizeRaw = size(RawObs);
n = SizeRaw(1);

%Build Tracker Number, Jd, and Obs matrices

for i = 1:n;
    
    Jd(i,1) = julianday(RawObs(i,3),RawObs(i,4),RawObs(i,5),RawObs(i,6),...
                        RawObs(i,7),RawObs(i,8));
    
    %Find Site Position, Measurement Biases, and Standard Dev for W matrix
    
    [LatLonAlt(i, 1), LatLonAlt(i, 2), LatLonAlt(i, 3), ...
     Bias(i, 1), Bias(i, 2), Bias(i, 3), Sigma(i,1), Sigma(i,2), Sigma(i,3)] ...
     = sitechar (RawObs(i,2));
 
        %Latitude and Longitude degrees to radians
 
        LatLonAlt(i, 1) = deg2rad(LatLonAlt(i, 1));
        LatLonAlt(i, 2) = deg2rad(LatLonAlt(i, 2));
        
        %Altitude to km
        
        LatLonAlt(i, 3) = LatLonAlt(i, 3)/1000; 
        
 
    %Observation Matrix corrected biases
    
        %Rho (m to km)
        Yobs(i,1) =  RawObs(i,9) - Bias(i,1)/1000;
    
        %Az (deg to rad)
        Yobs(i, 2) = deg2rad(RawObs(i,10)) - deg2rad(Bias(i,2));
        
        %El (deg to rad)
        Yobs(i,3) = deg2rad(RawObs(i,11)) - deg2rad(Bias(i,3));
    
    %Build W matrix
    
        %Rho
        W(i*3-2,i*3-2) = 1/(Sigma(i,1)/1000)^2;
    
        %Az
        W(i*3-1,i*3-1) = 1/deg2rad(Sigma(i,2))^2;
    
        %El
        W(i*3,i*3) = 1/deg2rad(Sigma(i,3))^2;
    
    
end


