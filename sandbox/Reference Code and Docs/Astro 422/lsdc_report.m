%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Richard Phernetton
%Date: 10 March 2015
%
% This function outputs pertinent LSDC information
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
%    Xf                Initial state vector                       (km;
%                                                                  km;
%                                                                  km;
%                                                                  km/s;
%                                                                  km/s;
%                                                                  km/s)
%
%    EpochJd            Epoch julian date                        (Days)
%
%    t_error            Final iteration error                    (none)
%
%    counter            LSDC iteration counter                   (none)
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
function lsdc_report(Xi, X, EpochJd, t_error, counter, A, btilde,covariance);

%Find Matrix dimensions

[A_rows,A_columns] = size(A);
[btilde_rows,btilde_columns] = size(btilde);
[covariance_rows,covariance_columns] = size(covariance);

%Covert to COEs

[P,a_i,e_i,inc_i,raan_i,argp_i,...
    nu_i] = elorb (Xi(1:3),Xi(4:6));

[P,a_f,e_f,inc_f,raan_f,argp_f,...
    nu_f] = elorb (X(1:3),X(4:6));

%Convert Epoch Julian Day

[Yr,Mon,D,H,M,S]=invjulianday(EpochJd);

%%
%Output
FID = fopen('LSDC_Report.txt','w');

fprintf(FID,'ASTRO 422 \r\n');
fprintf(FID,'LSDC \r\n');
fprintf(FID,'Richard Phernetton \r\n');
fprintf(FID,'No. of iterations:  % 12.0f   \r\n',counter);

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
fprintf(FID,'Position:           % 12.6f I km\r\n',X(1));
fprintf(FID,'                    % 12.6f J km\r\n',X(2));
fprintf(FID,'                    % 12.6f K km\r\n',X(3));
fprintf(FID,'Velocity:           % 12.6f I km/s\r\n',X(4));
fprintf(FID,'                    % 12.6f J km/s\r\n',X(5));
fprintf(FID,'                    % 12.6f K km/s\r\n',X(6));

fprintf(FID,'\r\n\r\nTrouble Shooting\r\n');
fprintf(FID,'*********************************');
fprintf(FID,'********************************\r\n');

fprintf(FID,'\r\nIteration Error:       % 12.6d   \r\n',t_error);
fprintf(FID,'\r\nA matrix:\r\n\r\n');
for i = 1:A_rows
    
	for j = 1:A_columns
        fprintf(FID,'% 10.4f ',A(i,j));
    end
	fprintf(FID,'\r\n');
end
fprintf(FID,'\r\nB tilde matrix:\r\n\r\n');
for i = 1:btilde_rows
    
	for j = 1:btilde_columns
        fprintf(FID,'% 10.4f ',btilde(i,j));
    end
	fprintf(FID,'\r\n');
end 
fprintf(FID,'\r\nCovariance matrix:\r\n\r\n');
for i = 1:covariance_rows
    
	for j = 1:covariance_columns
        fprintf(FID,'% 10.4f ',covariance(i,j));
    end
	fprintf(FID,'\r\n');
end 
fprintf(FID,'\r\nSigmas:\r\n\r\n');

fprintf(FID,'rx                  % 12.4f     \r\n',sqrt(covariance(1,1)));
fprintf(FID,'ry                  % 12.4f     \r\n',sqrt(covariance(2,2)));
fprintf(FID,'rz                  % 12.4f     \r\n',sqrt(covariance(3,3)));
fprintf(FID,'vx                  % 12.4f     \r\n',sqrt(covariance(4,4)));
fprintf(FID,'vy                  % 12.4f     \r\n',sqrt(covariance(5,5)));
fprintf(FID,'vz                  % 12.4f     \r\n',sqrt(covariance(6,6)));

fclose(FID);