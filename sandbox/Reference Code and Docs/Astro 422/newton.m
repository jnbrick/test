%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                            Program newton
%%          Iterative function to calculate eccentric anomaly final using
%%          eccentricity and mean anomaly final
%%
%%    Author       : Cadet Richard Phernetton,   5 Mar 13
%%
%%    Inputs:
%%      ecc        - Eccentricity
%%      Mf         - Mean Anomaly Final
%%
%%    Outputs:
%%      Ef         - Eccentric Anomaly Final
%%
%%    Globals:
%%      MU         - Mu (Earth)
%%      RE         - Radius of Earth
%%
%%    Locals:  
%%      Epast      - Previously Calculated Eccentric Anomaly 
%%      Ecurrent   - Current Calculated Eccentric Anomaly
%%      Tolerance  - Accuracy of Solution
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

function[Ef] = newton(ecc, Mf);

Tolerance = 1; %Set Tolerance to arbitrary high constant
Epast = Mf;     %First iteration guesses Mf *+ecc as E
Iterationcount = 0; %Count for book keeping
while Tolerance>10^(-9);  %Check Tolerance
    Ecurrent = Epast + (Mf - (Epast-ecc*sin(Epast)))/(1-ecc*cos(Epast));
        %^Newton's method base equation
    Tolerance = abs(Epast-Ecurrent);
        %Set Tolerance 
    Epast = Ecurrent;
        %Set new Epast
    Iterationcount = Iterationcount+1;
        %Count
end

Ef=Ecurrent;    %Set Ef; 'Ecurrent' was used to make it easier to follow.
