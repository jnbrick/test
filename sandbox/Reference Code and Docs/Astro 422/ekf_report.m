%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 March 2015
%
% This function outputs pertinent EKF information
%
% Input Variables:
%
%    Xi                Initial state vector                       (km;
%                                                                  km;
%                                                                  km;
%                                                                  km/s;
%                                                                  km/s;
%                                                                  km/s)
%
%    Xf                Final state vector                         (km;
%                                                                  km;
%                                                                  km;
%                                                                  km/s;
%                                                                  km/s;
%                                                                  km/s)
%
%    EpochJd            Epoch julian date                        (Days)
%
%    counter            LSDC iteration counter                   (none)
%
%    Pe                 Covariance Matrix                        (n x n)
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
function ekf_report(Xi, Xf, EpochJd, Pe);

%Find Matrix dimensions

[Pe_rows,Pe_columns] = size(Pe);

%Covert to COEs

[P,a_i,e_i,inc_i,raan_i,argp_i,...
    nu_i] = elorb (Xi(1:3),Xi(4:6));

[P,a_f,e_f,inc_f,raan_f,argp_f,...
    nu_f] = elorb (Xf(1:3),Xf(4:6));

%Convert Epoch Julian Day

[Yr,Mon,D,H,M,S]=invjulianday(EpochJd);

%%
%Output
FID = fopen('EKF_Report.txt','w');

fprintf(FID,'ASTRO 422 \r\n');
fprintf(FID,'EKF \r\n');
fprintf(FID,'Richard Phernetton \r\n');

fprintf(FID,'\r\n\r\nInputs\r\n');
fprintf(FID,'**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,'Semimajor Axis:     % 12.6f   km\r\n',a_i);
fprintf(FID,'Inclination:        % 12.6f   rad\r\n',inc_i);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(inc_i));
fprintf(FID,'Eccentricity:       % 12.6f   \r\n',e_i);
fprintf(FID,'RAAN:               % 12.6f   rad\r\n',raan_i);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(raan_i));
fprintf(FID,'Argument of Perigee:% 12.6f   rad\r\n',argp_i);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(argp_i));
fprintf(FID,'True Anomoly:       % 12.6f   rad\r\n',nu_i);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(nu_i));
fprintf(FID,'Position:           % 12.6f I km\r\n',Xi(1));
fprintf(FID,'                    % 12.6f J km\r\n',Xi(2));
fprintf(FID,'                    % 12.6f K km\r\n',Xi(3));
fprintf(FID,'Velocity:           % 12.6f I km/s\r\n',Xi(4));
fprintf(FID,'                    % 12.6f J km/s\r\n',Xi(5));
fprintf(FID,'                    % 12.6f K km/s\r\n',Xi(6));
fprintf(FID,'Year:               % 12.0f     \r\n',Yr);
fprintf(FID,'Month:              % 12.0f     \r\n',Mon);
fprintf(FID,'Day:                % 12.0f     \r\n',D);
fprintf(FID,'Hour:               % 12.0f     \r\n',H);
fprintf(FID,'Minute:             % 12.0f     \r\n',M);
fprintf(FID,'Second:             % 12.6f     \r\n',S);

fprintf(FID,'\r\n\r\nOutput\r\n');
fprintf(FID,'**************************************');
fprintf(FID,'*************************************\r\n');

fprintf(FID,'Semi Major Axis:    % 12.6f   km\r\n',a_f);
fprintf(FID,'Inclination:        % 12.6f   rad\r\n',inc_f);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(inc_f));
fprintf(FID,'Eccentricity:       % 12.6f   \r\n',e_f);
fprintf(FID,'RAAN:               % 12.6f   rad\r\n',raan_f);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(raan_f));
fprintf(FID,'Argument of Perigee:% 12.6f   rad\r\n',argp_f);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(argp_f));
fprintf(FID,'True Anomaly:       % 12.6f   rad\r\n',nu_f);
fprintf(FID,'                    % 12.6f   deg\r\n',rad2deg(nu_f));
fprintf(FID,'Position:           % 12.6f I km\r\n',Xf(1));
fprintf(FID,'                    % 12.6f J km\r\n',Xf(2));
fprintf(FID,'                    % 12.6f K km\r\n',Xf(3));
fprintf(FID,'Velocity:           % 12.6f I km/s\r\n',Xf(4));
fprintf(FID,'                    % 12.6f J km/s\r\n',Xf(5));
fprintf(FID,'                    % 12.6f K km/s\r\n',Xf(6));

fprintf(FID,'\r\n\r\nTrouble Shooting\r\n');
fprintf(FID,'*********************************');
fprintf(FID,'********************************\r\n');

fprintf(FID,'\r\nCovariance matrix (at epoch):\r\n\r\n');
for i = 1:Pe_rows
    
	for j = 1:Pe_columns
        fprintf(FID,'% 10.8f ',Pe(i,j));
    end
	fprintf(FID,'\r\n');
end

fprintf(FID,'\r\nSigmas:\r\n\r\n');

fprintf(FID,'rx                  % 12.8f     \r\n',sqrt(abs(Pe(1,1))));
fprintf(FID,'ry                  % 12.8f     \r\n',sqrt(abs(Pe(2,2))));
fprintf(FID,'rz                  % 12.8f     \r\n',sqrt(abs(Pe(3,3))));
fprintf(FID,'vx                  % 12.8f     \r\n',sqrt(abs(Pe(4,4))));
fprintf(FID,'vy                  % 12.8f     \r\n',sqrt(abs(Pe(5,5))));
fprintf(FID,'vz                  % 12.8f     \r\n',sqrt(abs(Pe(6,6))));

fclose(FID);