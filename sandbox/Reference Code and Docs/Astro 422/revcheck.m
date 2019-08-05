function y = revcheck (x, modby)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use          : y = revcheck (x, modby)
%%
%%    Accomplishes a modulus function of x by modby. While this does exactly
%%    the same operation as the MatLab mod function, it does it quicker  
%%    because the overhead is minimal. This has shown to be significant when
%%    propagating COEs at small time steps over large time spans.
%%
%%  inputs:
%%           x -  argument (radians, degrees, etc.)
%%       modby -  value to mod by (TwoPi, 360, etc.)
%%
%%  outputs:
%%           y -  x modulus modby
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109   12 Aug 1988
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110    2 Jul 1997
%%  In MatLab     : LtCol Thomas Yoder USAFA/DFAS  719-333-4110   Spring 2001
%%
%%  Locals:  None.
%%
%%  Constants:  None.
%%
%%  Coupling:  None.
%%  References:  None.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y = x - modby * fix(x / modby);

if (y ~= 0 && sign(y) ~= sign(modby))
   y = y + modby;
end