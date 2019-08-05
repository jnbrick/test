%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                            Program Update
%%            Accepts Initial COEs and TOF, calculates future COEs 
%%  
%%    Author       : Cadet Richard Phernetton,   04 May 13
%%
%%    Inputs:
%%      ai         - Semimajor Axis CURRENT
%%      ecci       - Eccentricity CURRENT
%%      incli      - Inclination CURRNET
%%      raani      - Right Ascension of Ascending Node CURRENT
%%      argpi      - Argument of Perigee CURRENT
%%      nui        - True Anomaly CURRENT
%%      tof        - Time Of Flight
%%
%%    Outputs:
%%      af         - Semimajor Axis FUTURE
%%      ef         - Eccentricity FUTURE
%%      inclf      - Inclination FUTURE
%%      raanf      - Right Ascension of Ascending Node FUTURE
%%      argpf      - Argument of Perigee FUTURE
%%      nuf        - True Anomaly FUTURE
%%
%%    Globals:
%%      Mu         - Mu (Earth)
%%      RE         - Radius of Earth
%%
%%    Locals:  
%%      n          - um.... n
%%      Ei         - Eccentric Anomoly Initial
%%      Ef         - Eccentric Anomoly Final
%%      Mi         - Mean Anomoly Initial
%%      Mf         - Mean Anomoly Final
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

function [af,ef,inclf,raanf,argpf,nuf] = update(ai,ei,incli,raani,argpi,nui,tof)

global MU

n = sqrt(MU/ai^3);
%calculates n

af = ai;
inclf = incli;
raanf = raani;
argpf = argpi;

%Semimajor Axis, Inclination, Raan, and Argument of Per don't change with
%time

Ei = acos((ei+cos(nui))/(1+ei*cos(nui)));
    Ei = revcheck(Ei, 2*pi);
%revcheck Ei to insure 0<Ei<2pi
    if nui > pi;
        Ei = 2*pi - Ei;
    end;
        %Calculates Ei with nui and performs half-pane check
    
Mi = Ei - ei*sin(Ei);
%Calculates Mi with Ei

Mf = Mi+n*tof;
%Updates Mean Anomoly
    Mf = revcheck(Mf, 2*pi);
%revcheck Mf to insure 0<Mf<2pi

Ef = newton(ei, Mf);
%Iterates Mf to find Ef
    Ef = revcheck(Ef, 2*pi);
%revcheck Ef to insure 0<Ef<2pi

nuf = acos((cos(Ef)-ei)/(1-ei*cos(Ef)));
    if Ef > pi;
        nuf = 2*pi - nuf;
    end;
        %Calculates nuf with Ef and performs a half-plane check


ef = ei;

%Eccentricity doesn't change

