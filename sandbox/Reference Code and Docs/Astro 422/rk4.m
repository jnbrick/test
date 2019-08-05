function [X2] = rk4 ( IDate, Dt, DerivType, BC, X )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [X2] = rk4 ( IDate, Dt, DerivType, BC, X )
%%
%%  This function is a fourth order Runge-Kutta integrator for a 6 dimension
%%    First Order differential equation.  The intended use is for a satellite
%%    equation of motion.  The user must provide an external function containing
%%    the system Equations of Motion.  Notice Julian date is included since some
%%    applications in PDERIV may need this.  The LAST position in DerivType is a
%%    flag for two-body motion.  Two-Body motion is used if the 10th element is
%%    set to "2", otherwise the Yes and No values determine which perturbations
%%    to use.
%%  The integration is done for one time step only.
%%
%%  Algorithm     : Evaluate each term depending on the derivtype
%%                  Find the final answer
%%                  Notice the 4th k must be mult by Dt since k1-k3 did so in assignval
%%                  Also, the 4th k is left as xdot since it was just calculated
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109    5 Jun 1991
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110   12 Jan 1996
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109   16 Jan 2002
%%  Doc Fix       : Dr Scott Dahlke    USAFA/DFAS  719-333-4462   29 Jan 2008
%%
%%  Inputs        :
%%    IDate       - Initial Time Julian Date                   days since 4713 B.C.
%%
%%    Dt          - Step size                                  sec
%%    DerivType   - String containing YN for incl perts        "yynynynnn1"
%%    BC          - Ballistic Coefficient                      kg/m2
%%    X           - State vector at initial time               km, km/sec
%%
%%  Outputs       :
%%    X           - State vector at new time                   km, km/sec
%%
%%  Locals        :
%%    XDot        - Derivative of State Vector
%%    K1,K2,K3    - Storage for values of state vector at different times
%%                  (The standard Runge-Kutta K constants)
%%    TEMP        - Storage for state vector
%%    TempDate    - Temporary date storage half way between dt days since 4713 B.C.
%%
%%  Constants     :
%%    None.
%%
%%  Coupling      :
%%    Deriv         function for Derivatives of E.O.M.
%%    PDeriv        function for Derivatives of E.O.M. with Perturbations
%%
%%  References    :
%%    Mathews, "Numerical Methods" pg. 423-427
%%    BMW           pg. 414-415
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-


%% Local VARIABLES
     %%%%%%%%%%%%%%%% Evaluate 1st Taylor Series Term %%%%%%%%%%%%%%%%
     if DerivType(10:10) == '2' ,
         [XDot] = deriv( X );
     else
         [XDot] = pderiv( IDate,X,DerivType,BC );
     end

     %%%%%%%%%%%%%%%% Update Julian Date for a half Dt %%%%%%%%%%%%%%-
     TempDate = IDate + Dt * 0.5 / 86400.0;

     %%%%%%%%%%%%%%%% Evaluate 2nd Taylor Series Term %%%%%%%%%%%%%%%%
         K1 = Dt * XDot;
         Temp = X + 0.5 * K1;

     if DerivType(10:10) == '2' ,
         [XDot] = deriv( Temp );
     else
         [XDot] = pderiv( TempDate,Temp,DerivType,BC );
     end

     %%%%%%%%%%%%%%%% Evaluate 3rd Taylor Series Term %%%%%%%%%%%%%%%%
         K2 = Dt * XDot;
         Temp = X + 0.5 * K2;

     if DerivType(10:10) == '2' ,
         [XDot] = deriv( Temp );
     else
         [XDot] = pderiv( TempDate,Temp,DerivType,BC );
     end

     %%%%%%%%%%%%%%%% Evaluate 4th Taylor Series Term %%%%%%%%%%%%%%%%
         K3 = Dt * XDot;
         Temp = X + K3;

     %%%%%%%%%%%%%%%% Update Julian Date for a full Dt %%%%%%%%%%%%%%-
     TempDate = IDate + Dt / 86400.0;

     if DerivType(10:10) == '2' ,
         [XDot] = deriv( Temp );
     else
         [XDot] = pderiv( TempDate,Temp,DerivType,BC );
     end

     %%%%%%%%%%- Update the State vector, perform integration %%%%%%-
     X2 = X + ( K1  + 2.0 * ( K2 + K3 ) + Dt * XDot) / 6.0;


