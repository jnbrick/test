function [Yr,Mon,D,H,M,S]=invjulianday(JD)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [Yr,Mon,D,H,M,S]=invjulianday(JD)
%%
%%  This function finds the Year, month, day, hour, minute and second
%%  given the Julian date.
%%
%%  Algorithm     : Set up starting values
%%                  Find the elapsed days through the year in a loop
%%                  Call routine to find each individual value
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  26 Feb 1990
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In Matlab     : LtCol Thomas Yoder USAFA/DFAS  719-333-4110  Spring 2000
%%
%%  Inputs        :
%%    JD          - Julian Date                          days from 4713 B.C.
%%
%%  OutPuts       :
%%    Yr          - Year                                 1900 .. 2100
%%    Mon         - Month                                   1 .. 12
%%    D           - Day                                     1 .. 28,29,30,31
%%    H           - Hour                                    0 .. 23
%%    M           - Minute                                  0 .. 59
%%    S           - Second                                0.0 .. 59.999
%%
%%  Locals        :
%%    days        - Day of year plus fraction of a day   days
%%    Tu          - Julian Centuries from 1 Jan 1900
%%    Temp        - Temporary Long_Float value
%%    LeapYrs     - Number of Leap years from 1900
%%
%%  Constants     :
%%    None.
%%
%%  Coupling      :
%%    DayofYr2MDHMS  - Finds Month, day, hour, minute and second given Days and Yr
%% 
%%  References    :
%%    1988 Almanac for Computers  pg. B2
%%    Escobal       pg. 17-19
%%    Kaplan        pg. 329-330
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% Find Year and Days of the year %%%%%%%%%%%%%%-
     Temp= JD-2415019.5;
     Tu = Temp / 365.25;
     Yr = 1900 + fix( Tu );
     LeapYrs= fix(( Yr-1900-1 )*0.25 );
     Days= Temp - ((Yr-1900)*365.0 + LeapYrs );

%%%%%%%%%%- Check for case of beginning of a year %%%%%%%%%%-
     if Days < 1.0 
         Yr= Yr - 1;
         LeapYrs= fix(( Yr-1900-1 )*0.25 );
         Days= Temp - ((Yr-1900)*365.0 + LeapYrs );
     end

%%%%%%%%%%%%%%%% Find remaining data  %%%%%%%%%%%%%%%%%%%%%%%%-
     [Mon,D,H,M,S]=dayofyr2mdhms(Yr,Days);
