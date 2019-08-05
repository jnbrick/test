%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                            Program RVpqw
%%            Accepts af eccf and nuf, calculates RV in pqw cooridinates
%%  
%%    Author       : Cadet Richard Phernetton,   04 May 13
%%
%%    Inputs:
%%      af         - Semimajor Axis FUTURE
%%      eccf       - Eccentricity FUTURE
%%      nuf        - True Anomaly FUTURE
%%
%%    Outputs:
%%      Rpqw       – future position vector in PQW
%%      Vpqw       – future velocity vector  in PQW
%%
%%    Globals:
%%      Mu         - Mu (Earth)
%%      RE         - Radius of Earth
%%
%%    Locals:
%%      P          - Semi-latus Rectum
%%
%%    Constants: 
%%      pi         - 3.1415 . . .
%%      g          - gravitational acceleration            m/sec^2
%%
%%    Coupling: None
%%
%%    References   :
%%         Astro 201 Notes Lesson 6
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [Rpqw, Vpqw] = RVpqw(af, eccf, nuf);

%WGS84Data
global MU;

P = af*(1-eccf^2);
%find semi-latus rectum; ignores parabolic orbits for now

Rpqw = (P/(1+eccf*cos(nuf)))*[cos(nuf);sin(nuf);0];
%finds Rpqw [P;Q;W]

Vpqw = sqrt(MU/P)*[-sin(nuf);(eccf+cos(nuf));0];
%finds Vpqw [P;Q;W]
