%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 12 January 2015
%
% This function calculates the positive accute angular difference between 
% two given angles
%
% Input Variables:
%   
%    a                  Angle 1                              (rad)
%
%    b                  Angle 2                              (rad)
%
%
% Output Variables:     
%
%    c                  Accute angular difference            (rad)
%
% Usage  
%   
%   c = angdif(a,b)
%   
% Globals:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function c = angdif(a,b)

%Revcheck each angle

ap = revcheck(a, 2*pi);

bp = revcheck(b, 2*pi);

%Find initial angular difference

cp = abs(ap-bp);

%Modify

if cp < pi;
    
    c = cp;
    
else
    
    c = 2*pi-cp;

end
