function [Mon,D,H,M,Sec]=dayofyr2mdhms(Yr,Days)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [Mon,D,H,M,Sec]=dayofyr2mdhms(Yr,Days)
%%
%%  This function converts the day of the year, days, to the month
%%    day, hour, minute and second.
%%
%%  Algorithm     : Set up array for the number of days per month
%%                  loop through a temp value while the value is < the days
%%                  Perform integer conversions to the correct day and month
%%                  Convert remainder into H M S using type conversions
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS     719-472-4109  26 Feb 1990
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS     719-472-4110  17 May 1995
%%  In MATLAB     : LtCol Thomas L. Yoder USAFA/DFAS  719-472-4110  Spring 00
%%
%%  Inputs        :
%%    Yr          - Year                                 1900 .. 2100
%%    Days        - Julian Day of the year               1.0  .. 366.0
%%
%%  OutPuts       :
%%    Mon         - Month                                   1 .. 12
%%    D           - Day                                     1 .. 28,29,30,31
%%    H           - Hour                                    0 .. 23
%%    M           - Minute                                  0 .. 59
%%    Sec         - Second                                0.0 .. 59.999
%%
%%  Locals        :
%%    DayOfyr     - Day of year
%%    Temp        - Temporary Long_Float value
%%    IntTemp     - Temporary 16 bit Integer value
%%    i           - Index
%%
%%  Constants     :
%%    LMonth(12)  - Integer Array containing the number of days per month
%%
%%  Coupling      : None
%%
%%  References    :
%%    None.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	  DayOfYr= fix(Days);

%%%%%%%%%%%%%%%% Find month and Day of month %%%%%%%%%%%%%%%%
	  LMonth= [31;28;31;30;31;30;31;31;30;31;30;31];
     if mod((Yr-1900),4) == 0
         LMonth(2)= 29;
     end
     i= 1;
     IntTemp= 0;
     while ( DayOfYr > IntTemp + LMonth(i) ) & ( i < 12 )
         IntTemp= IntTemp + LMonth(i);
         i= i+1;
     end
     Mon= i;
     D = DayOfYr - IntTemp;

%%%%%%%%%%%%%%%% Find hours minutes and seconds %%%%%%%%%%%%%%
     Temp= (Days - DayOfYr)*24.0;
     H   = fix( Temp );
     Temp= (Temp-H) * 60.0;
     M   = fix( Temp );
     Sec = (Temp-M) * 60.0;
