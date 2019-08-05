%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 January 2015
%
% This function calculates the derivative of the two-body state vector with 
% perturbations for use with the Runge-Kutta algorithm.
%
% Input Variables:
%
%    IDate              Initial Time Julian Date     
%
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
%    X                  State vector at initial time         (km;
%                                                             km;
%                                                             km;
%                                                             km/s;
%                                                             km/s;
%                                                             km/s)
%   
% Output Variables:     
%
%    XDot               Derivitabe of state vector           (km/s;
%                                                             km/s;
%                                                             km/s;
%                                                             km/s^2;
%                                                             km/s^2;
%                                                             km/s^2)
%
%
% Usage  
%   
%   [XDot] = pderiv(IDate,X,DerivType,BC)
%   
% Globals:
%
%   wgs84data           World Geodetic System 1984 Data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [XDot] = pderiv(IDate,X,DerivType,BC)


%Call Globals

wgs84data
global MU
global OmegaEarth
global J2
global J3
global J4
global RE
global GMS
global GMM


%Unpack Vectors
R = [X(1);X(2);X(3)];
V = [X(4);X(5);X(6)];


%Drag

if DerivType(1) == 'n';
         Ad = [0;0;0];
     else
         %Drag Model
         Vatmos = cross([0;0;OmegaEarth],R);
         Vrel = V - Vatmos;
         Rho = atmos76(R);
         Ad = -(Rho*mag(Vrel))/(2*BC)*Vrel;
         
end

%J2

if DerivType(2) == 'n';
         Aj2 = [0;0;0];
     else
         %J2 Model
         aj2x = -(3*J2*MU*RE^2*R(1)/(2*mag(R)^5))*(1-5*(R(3)^2)/mag(R)^2);
         aj2y = -(3*J2*MU*RE^2*R(2)/(2*mag(R)^5))*(1-5*(R(3)^2)/mag(R)^2);
         aj2z = -(3*J2*MU*RE^2*R(3)/(2*mag(R)^5))*(3-5*(R(3)^2)/mag(R)^2);
         
         Aj2 = [aj2x; aj2y; aj2z];
end

%J3

if DerivType(3) == 'n';
         Aj3 = [0;0;0];
     else
         %J3 Model
         aj3x = -(5*J3*MU*RE^3*R(1)/(2*mag(R)^7))*(3*R(3)-7*(R(3)^3)/mag(R)^2);
         aj3y = -(5*J3*MU*RE^3*R(2)/(2*mag(R)^7))*(3*R(3)-7*(R(3)^3)/mag(R)^2);
         aj3z = -(5*J3*MU*RE^3*R(3)/(2*mag(R)^7))*(6*R(3)-7*(R(3)^3)/mag(R)^2-3*mag(R)^2/(5*R(3)));
         
         Aj3 = [aj3x; aj3y; aj3z];
end

%J4

if DerivType(4) == 'n';
         Aj4 = [0;0;0];
     else
         %J4 Model
         aj4x = -(15*J4*MU*RE^4*R(1)/(8*mag(R)^7))*(1-14*(R(3)^2)/(mag(R)^2)-21*(R(3)^4)/mag(R)^4);
         aj4y = -(15*J4*MU*RE^4*R(2)/(8*mag(R)^7))*(1-14*(R(3)^2)/(mag(R)^2)-21*(R(3)^4)/mag(R)^4);
         aj4z = -(15*J4*MU*RE^4*R(3)/(8*mag(R)^7))*(5-70*(R(3)^2)/(3*mag(R)^2)-21*(R(3)^4)/mag(R)^4);
         
         Aj4 = [aj4x; aj4y; aj4z];
         
end

%Sun

Rearthsun = sun(IDate);             %Calculated outside of the IF statement
                                    %b/c it will be needed in Solar
                                    %Radiation portion

if DerivType(5) == 'n';
         A3s = [0;0;0];
     else
         %Sun Model
         Rsatsun = Rearthsun - R;
         

         q = (mag(R)^2+2*(dot(R,Rsatsun)))/...
             ((mag(Rearthsun)^3)*(mag(Rsatsun)^3)) * ...
             (mag(Rearthsun)^2+mag(Rearthsun)*mag(Rsatsun)+mag(Rsatsun)^2)/...
             (mag(Rearthsun)+mag(Rsatsun));
         
         A3s = GMS*(Rsatsun*q-R/mag(Rearthsun)^3);
end

%Moon

if DerivType(6) == 'n';
         A3m = [0;0;0];
     else
         %Moon model
         Rearthmoon = moon (IDate);
         Rsatmoon = Rearthmoon - R;
         

         q = (mag(R)^2+2*(dot(R,Rsatmoon)))/...
             ((mag(Rearthmoon)^3)*(mag(Rsatmoon)^3)) * ...
             (mag(Rearthmoon)^2+mag(Rearthmoon)*mag(Rsatmoon)+mag(Rsatmoon)^2)/...
             (mag(Rearthmoon)+mag(Rsatmoon));
         
         A3m = GMM*(Rsatmoon*q-R/mag(Rearthmoon)^3);
end

%Solar radiation pressure

if DerivType(7) == 'n';
         Asr = [0;0;0];
     else
         %Solar radiation pressure model
         
         beta = vecangle(R,Rearthsun);
         Psr = 4.51E-6;                 %Solar Pressure (Nm^2)
         Cr = 1.0;                      %Coef. of reflectivity
         Ar = 16.4;                     %Reflectivity area (m^2)
         m = 12000;                     %Satellite mass (kg)
         
         if beta > pi/2;
             if R*sin(pi-beta)< RE;
                 Asr = [0;0;0];
             else
                 Asr = -(Psr*Cr*Ar/m)*(Rearthsun/mag(Rearthsun));
             end
         else
             Asr = -(Psr*Cr*Ar/m)*(Rearthsun/mag(Rearthsun));
         end
   
end

%Build Xdot

XDot = [X(4); ...
        X(5); ...
        X(6); ...
        X(1) * -MU/mag(R)^3+Ad(1)+Aj2(1)+Aj3(1)+Aj4(1)+A3s(1)+A3m(1)+Asr(1); ...
        X(2) * -MU/mag(R)^3+Ad(2)+Aj2(2)+Aj3(2)+Aj4(2)+A3s(2)+A3m(2)+Asr(2); ...
        X(3) * -MU/mag(R)^3+Ad(3)+Aj2(3)+Aj3(3)+Aj4(3)+A3s(3)+A3m(3)+Asr(3)];





