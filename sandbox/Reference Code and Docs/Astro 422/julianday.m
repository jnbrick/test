function JD=julianday(Yr,Mon,D,H,M,S)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : JD=julianday(Yr,Mon,D,H,M,S)
%%
%%  This function finds the Julian date given the Year, Month, Day, and Time.
%%    The Julian date is defined by each elapsed day since noon, 1 Jan 4713 BC.
%%    Julian dates are measured from this epoch at noon so astronomers
%%    observations may be performed on a single "day".  The year range is
%%    limited since machine routines for 365 days a year and leap years are
%%    valid in this range only.  This is due to the fact that leap years occur
%%    only in years divisible by 4 and centuries whose number is evenly
%%    divisible by 400. ( 1900 no, 2000 yes ... )
%%
%%  NOTE:  This Algorithm is taken from the 1988 Almanac for Computers,
%%    Published by the U.S. Naval Observatory.  The algorithm is good for dates
%%    between 1 Mar 1900 to 28 Feb 2100 since the last two terms (from the
%%    Almanac) are commented out.  Including the last two terms enables
%%    calculations between 1 Mar 1801, and 2100.
%%
%%  Algorithm     : Find the various terms of the expansion
%%                  Calculate the answer
%%
%%  Author        : Capt Dave Vallado     USAFA/DFAS  719-472-4109  12 Aug 1988
%%  In Ada        : Dr Ron Lisowski       USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : LtCol Thomas L. Yoder USAFA/DFAS  719-333-4110  Spring 00
%%
%%  Inputs        :
%%    Yr          - Year                                1900 .. 2100
%%    Mon         - Month                                  1 .. 12
%%    D           - Day                                    1 .. 28,29,30,31
%%    H           - Universal Time Hour                    0 .. 23
%%    M           - Universal Time Min                     0 .. 59
%%    Sec         - Universal Time Sec                   0.0 .. 59.999
%%
%%  Outputs       :
%%    JD          - Julian Date                          days from 4713 B.C.
%%
%%  Locals        :
%%    Term1       - Temporary Long_Float value
%%    Term2       - Temporary 32 bit INTEGER value
%%    Term3       - Temporary 32 bit INTEGER value
%%    UT          - Universal Time                           days
%%
%%  Constants     : None.
%%
%%  Coupling      : None.
%%
%%  References    :
%%    1988 Almanac for Computers  pg. B2
%%    Escobal       pg. 17-19
%%    Kaplan        pg. 329-330
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TERM1= 367.0 * Yr;
TERM2= fix( ( 7.0 * (Yr + fix((Mon+9.0)/12.0))) * 0.25);
TERM3= fix(275.0 * Mon / 9.0 );
UT= ( (S/60.0 + M ) / 60.0 + H ) / 24.0;

JD= (TERM1-TERM2+TERM3) + D + UT + 1721013.5;
%%   The following neglected term must be added for dates before 28 Feb 1900     
%%      + 0.5*sign( (100*Yr + Mon) - 190002.5) + 0.5;

