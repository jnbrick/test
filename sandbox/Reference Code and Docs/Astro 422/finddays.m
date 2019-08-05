function DDays=finddays(Year,Month,Day,Hr,Min,Sec)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : DDays=finddays(Year,Month,Day,Hr,Min,Sec)
%%
%%  This function finds the fractional days through a year given the year,
%%    month, day, hour, minute and second. Midnight New Year's is 0.0
%%
%%  Algorithm     : Set up array for the number of days per month
%%                  Check for a leap year
%%                  Loop to find the elapsed days in the year
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  11 Dec 1990
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : LtCol Thomas Yoder USAFA/DFAS  719-333-4110  Spring 2000
%%
%%  Inputs        :
%%    Year        - Year                                 1900 .. 2100
%%    Month       - Month                                   1 .. 12
%%    Day         - Day                                     1 .. 28,29,30,31
%%    Hr          - Hour                                    0 .. 23
%%    Min         - Minute                                  0 .. 59
%%    Sec         - Second                                0.0 .. 59.999
%%
%%  OutPuts       :
%%    DDays        - Fractional elapsed day of year    days
%%
%%  Locals        :
%%    i           - Index
%%	  LMonth	  - array holding number of days in each month
%%
%%  Constants     :
%%    None.
%%
%%  Coupling      :
%%    None.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

	  LMonth= [31;28;31;30;31;30;31;31;30;31;30;31];
     if mod((Year-1900),4) == 0
         LMonth(2)= 29;
     end

     i = 1;
     DDays= 0.0;
     while (i < Month) & ( i < 12 )
         DDays= DDays + LMonth(i);
         i= i + 1;
     end
     DDays= DDays + (Day-1) + Hr/24.0 + Min/1440.0 + Sec/86400.0;
