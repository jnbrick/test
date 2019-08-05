function [gst,lst] = gstlst(jd,sitlon)
wgs84data
global SidePerSol

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This procedure computes the Greenwich Sidereal Time and Local Sidereal 
%   time at the time contained in the Julian date passed in.
% 
% Author: C2C Richard Phernetton, CS05, Fall 2013
%
% Input:	
%   jd      julian date				
% 	sitlon	site longitude			radians
% 	
% Output:	
%   gst     Greenwich sidereal time			0 < gst < 2pi rad
% 	lst     local sidereal time             0 < lst < 2pi rad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Unwrap julian day

[Year,Month,Day,Hr,Min,Sec]=invjulianday(jd);
D = finddays(Year,Month,Day,Hr,Min,Sec);

%Find GST

GST0=gstime(Year);
gst = GST0 + SidePerSol*(2*pi)*D;
gst = revcheck(gst,2*pi);

%Find LST
lst = gst + sitlon;
lst = revcheck(lst,2*pi);




