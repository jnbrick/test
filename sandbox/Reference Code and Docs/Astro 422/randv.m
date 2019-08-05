function [R,V] = randv ( P,Ecc,Incl,RAAN,Argp,Nu,U,L,CapPi)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [R,V] = randv ( P,Ecc,Incl,RAAN,Argp,Nu,U,L,CapPi)
%%
%%  This function finds the position and velocity vectors in Geocentric
%%    Equatorial (IJK) system given the classical orbit elements.  Note that
%%    P is used for calculations and that semi-major axis a, is not.  This
%%    convention allows parabolic trajectories to be treated as well as 
%%    the other conic sections.  
%%    Also, the 6 angles Argp, Omega, Nu, U, L and CapPi are
%%    either finite numbers or the IEEE standard NaN for undefined.
%%    The function processes different types of orbits with ONE  
%%    transformation matrix keying off of which angles are finite.
%%    
%%  Unless U, L, or CapPi are intended to be defined, ensure they are all
%%    set equal to NaN by the calling function.
%%
%%  Algorithm     : Based on whether the angle elements are finite
%%                     assign OMEGA, ARGP, and NU appropriately, taking
%%                     advantage of cases sensitivity, e.g Nu /= NU.
%%                     These values are NOT passed back as they do not
%%                     appear in the output parameter list.
%%                  Find the PQW position and veocity vectors using
%%                     true anomaly or its equivalent
%%                  Rotate by 3-1-3 to IJK.  Order is important
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  20 Sep 1990
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109  10 Oct 2001
%%
%%  Inputs        :
%%    P           - Semi-latus rectum                      km
%%    Ecc         - eccentricity                           0.0 to ...
%%    Incl        - inclination                            0.0 to Pi  rad
%%    RAAN        - Right Acension of Ascending Node       0.0 to 2Pi rad
%%    Argp        - Argument of Perigee                    0.0 to 2Pi rad
%%    Nu          - True anomaly                           0.0 to 2Pi rad
%%    U           - Argument of Latitude       (CI)        0.0 to 2Pi rad
%%    L           - True Longitude             (CE)        0.0 to 2Pi rad
%%    CapPi       - Longitude of Periapsis     (EE)        0.0 to 2Pi rad
%%
%%  Outputs       :
%%    R           - IJK Position vector                    km
%%    V           - IJK Velocity vector                    km / sec
%%
%%  Locals        :
%%    Temp        - Temporary Long_Float value
%%    Rpqw        - PQW Position vector                    km
%%    Vpqw        - PQW Velocity vector                    km / sec
%%    TempVec     - PQW Velocity vector
%%    OMEGA       - First Transformation Angle             0.0 to 2Pi rad
%%    ARGP        - Third Transformation Angle             0.0 to 2Pi rad
%%    NU          - True Anomaly or its equivalent         0.0 to 2Pi rad
%%
%%  Constants     :
%%    Pi
%%    MU          - Earth's Gravitaional Parameter         km^3 / sec^2
%%
%%  Coupling      :
%%    mag           Vector Magnitude & Cross Product
%%    axisrot       Euler angle rotation about an axis
%%
%%  References    :
%%    BMW           pg. 71-73, 80-83
%%    Escobal       pg. 68-83
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%Global Constants
      global MU

     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%  Determine what type of orbit is involved and set up the
     %%  set up angles for the special cases.
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         if isfinite(L) ,
             %%%%%%%%%%%%  Circular Equatorial  %%%%%%%%%%%%%%
             ARGP = 0.0;
             OMEGA= 0.0;
             NU   = L;
         elseif isfinite(U),
             %%%%%%%%%%%%  Circular Inclined  %%%%%%%%%%%%%%%%
             ARGP = 0.0;
             OMEGA = RAAN;
             NU  = U;
             %%%%%%%%%%%%  Elliptical Equatorial  %%%%%%%%%%%%
         elseif isfinite(CapPi),
             ARGP  = CapPi;
             OMEGA = 0.0;
             NU = Nu;
             %%%%%%%%%%%%  Elliptical Inclined    %%%%%%%%%%%%
         else
             ARGP = Argp;
             OMEGA = RAAN;
             NU  = Nu;
         end

     %%%%%%%%%%%%  Form PQW position and velocity vectors %%%%%%%%%%%%
     Temp = P / (1.0 + Ecc*cos(NU));
     Rpqw = [cos(NU); ...
             sin(NU); ...
             0.0]*Temp;
     Vpqw =  [-sin(NU); ...
              (Ecc + cos(NU)); ...
              0.0] * sqrt(MU / P);

     %%%%%%%%%%%%%%%%  Perform transformation to IJK  %%%%%%%%%%%%%%%%
     R = axisrot( axisrot( axisrot( Rpqw,3,-ARGP ),1,-Incl),3,-OMEGA );

     V = axisrot( axisrot( axisrot( Vpqw,3,-ARGP ),1,-Incl),3,-OMEGA );











