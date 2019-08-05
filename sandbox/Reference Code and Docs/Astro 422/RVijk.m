%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                            Program RVijk
%%            Rotates the position and velocity vectors into the 
%%                  Geocentric-Equatorial reference frame
%%  
%%    Author       : Cadet Richard Phernetton,   04 May 13
%%
%%    Inputs:
%%      Rpqw       – future position vector in PQW
%%      Vpqw       – future velocity vector  in PQW
%%      inclf      - Inclination FUTURE
%%      raanf      - Right Ascension of Ascending Node FUTURE
%%      argpf      - Argument of Perigee FUTURE
%%
%%    Outputs:
%%      Rijk       – future position vector in IJK
%%      Vijk       – future velocity vector  in IJK
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

function [Rijk,Vijk]=RVijk (Rpqw,Vpqw, inclf, raanf, argpf);

%WGS84Data
global MU;

Rijk = axisrot(Rpqw,3,-argpf); 
Vijk = axisrot(Vpqw,3,-argpf);
%%Rot 3, -argument of perigee

Rijk = axisrot(Rijk,1,-inclf); 
Vijk = axisrot(Vijk,1,-inclf);
%%Rot 1, -inclination

Rijk = axisrot(Rijk,3,-raanf); 
Vijk = axisrot(Vijk,3,-raanf);
%%Rot 3, - right ascension of the ascending node

