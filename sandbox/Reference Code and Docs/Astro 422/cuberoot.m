function temp = cuberoot ( XVal )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use          : temp = cuberoot ( XVal )
%%
%%  This function Rteurns the Cube Root of a real number.
%%
%%  Author       :  Dr Ron Lisowski  USAFA/DFAS  719-333-4110   15 Aug 1997
%%  In MatLab    :  Dr Ron Lisowski  USAFA/DFAS  719-333-4109    2 Jul 2001
%%
%% Inputs        :
%%
%%   XVal        - Input Value                                  any real
%%
%% OutPuts       :
%%   temp        - Returned                                     any real
%%
%% Locals        :
%%   None.
%%
%% Constants     :
%%   None.
%%
%% Coupling      :
%%   None.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

          temp = sign(XVal) * abs(XVal)^(1/3);
