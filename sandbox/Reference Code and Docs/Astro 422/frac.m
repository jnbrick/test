function temp = frac  ( XVal  )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use          : temp = frac  ( XVal  )
%%
%%  This function Truncates the integer part of a real number.
%%
%%  In Ada       : Dr Ron Lisowski  USAFA/DFAS  719-472-3315   23 Jan 1995
%%  In MatLab    : Dr Ron Lisowski  USAFA/DFAS  719-333-4109   2 Jul 2001
%%
%% Inputs        :
%%
%%   XVal        - Input Value                                  any real
%%
%% OutPuts       :
%%   temp       - Result                                       any integer
%%
%% Locals        :
%%   None.
%%
%% Constants     :
%%   None.
%%
%% Coupling      :
%%   None.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%- %%


          temp = XVal - fix ( XVal);

