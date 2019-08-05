function temp = trunc  ( XVal  )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use          : temp = trunc  ( XVal  )
%%
%%  This function Truncates the decimal part of a real number. Same as fix
%%
%%  Author       : Dr Ron Lisowski   USAFA/DFAS  719-472-3315   23 Jan 1995
%%  In MatLab    : Dr Ron Lisowski   USAFA/DFAS  719-333-4109    2 Jul 2001
%%
%% Inputs        :
%%
%%   XVal        - Input Value                                  any real
%%
%% OutPuts       :
%%   TRUNC       - Returned                                     any 32 bit integer
%%
%% Locals        :
%%   Temp        - Temporary 32 bit Integer Value
%%
%% Constants     :
%%   None.
%%
%% Coupling      :
%%   None.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


          temp = fix (XVal);
