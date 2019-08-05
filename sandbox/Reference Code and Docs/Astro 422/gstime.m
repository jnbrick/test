function Temp = gstime ( JD )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : Temp = gstime ( JD )
%%
%%  This function finds the Greenwich Sidereal time.  Notice just the integer
%%    part of the Julian Date is used for the Julian centuries calculation.
%%
%%  Algorithm     : Perform expansion calculation to obtain the answer
%%                  Check the answer for the correct quadrant and size
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  12 Feb 1989
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109   2 Jul 2001
%%
%%  Inputs        :
%%    JD          - Julian Date                          days from 4713 B.C.
%%
%%  OutPuts       :
%%    GSTime      - Greenwich Sidereal Time              0 to 2Pi rad
%%
%%  Locals        :
%%    Temp        - Temporary variable for reals         rad
%%    Tu          - Julian Centuries from 1 Jan 2000
%%
%%  Constants     :
%%    TwoPi       - Defined in DFASMath package
%%    RadPerDay   - Rads Earth rotates in 1 Solar Day
%%
%%  Coupling      :
%%    revcheck      Simplified MOD function
%%
%%  References    :
%%    1989 Astronomical Almanac pg. B6
%%    Escobal       pg. 18 - 21
%%    Explanatory Supplement pg. 73-75
%%    Kaplan        pg. 330-332
%%    BMW           pg. 103-104
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Constants
global RadPerDay TwoPI


     Tu = ( trunc(JD) + 0.5 - 2451545.0 ) / 36525.0;
     %%Temp= 1.753368559 + 628.3319705*Tu + 6.770708127E-06*Tu*Tu +
     Temp= 1.753368559 + 628.3319705*Tu + 6.770708127E-06*Tu^2 + RadPerDay*( (frac( JD ) - 0.5) );

%%%%%%%%%%%%%%%%%%%%%%- Check quadrants %%%%%%%%%%%%%%%%%%%%-
     Temp= revcheck (Temp, TwoPI);
%%     if Temp < 0.0 
%%         Temp= Temp + TwoPI;
%%     end;

