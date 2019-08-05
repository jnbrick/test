function [XDot] = deriv ( X )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [XDot] = deriv ( X )
%%
%%  This function calculates the derivative of the two-body state vector for
%%    use with the Runge-Kutta algorithm.  Note time is not needed.
%%
%%  Algorithm     : Find the answer
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  28 Aug 1989
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110   5 Jan 1996
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109  14 Nov 2001
%%
%%  Inputs        :
%%    X           - State Vector                           km, km/sec
%%
%%  Outputs       :
%%    XDot        - Derivative of State Vector             km/sec,  km/se2
%%
%%  Locals        :
%%    RCubed      - Cube of R
%%    MU_R3       - Mu / R cubed
%%
%%  Constants     :
%%    None.
%%
%%  Coupling      :
%%    None.
%%
%%  References    :
%%    None.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Global Constants
     global MU

      %%%%%%%%%%%%%%%%%  Build the XDot Vector %%%%%%%%%%%%%%%%%%%%
     R= sqrt(X(1)^2+X(2)^2+X(3)^2);
     RCubed= R*R*R;
     MU_R3 = -MU/RCubed;
      %%%%%%%%%%%%%%%%%%%%  Velocity Terms  %%%%%%%%%%%%%%%%%%%%%%
     XDot = [X(4); ...
             X(5); ...
             X(6); ...
      %%%%%%%%%%%%%%%%%%  Acceleration Terms  %%%%%%%%%%%%%%%%%%%%
             X(1) * MU_R3; ...
             X(2) * MU_R3; ...
             X(3) * MU_R3];

