function [V2, Theta, Error] = herrgibbs ( R1,R2,R3,JD1,JD2,JD3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [V2, Theta, Error] = herrgibbs ( R1,R2,R3,JD1,JD2,JD3)
%%
%%  This function implements the Herrick-Gibbs approximation for orbit
%%    determination, and finds the middle velocity vector for the 3 given
%%    position vectors.  The method is good for fast calculations and small
%%    angles, <= 10 deg.  Notice the angle is passed back since vectors which
%%    are 12 deg apart may actually be accurate, while vectors which are 170 deg
%%    apart would not.  The observations MUST be sequential and taken on one
%%    revolution.  The Use of Julian Dates for input makes it much easier to
%%    perform calculations where the sights occur around midnight.  Several
%%    flags are passed back:
%%
%%           Error = "ok"
%%           Error = "not coplanar"
%%           Error = "angle > 10ø"
%%
%%    Notice a 1 deg tolerance is allowed for the coplanar check.  This is
%%    necessary to allow for noisy data in the estimation project.
%%
%%  Algorithm     : Initialize values including the answer
%%                  Find if the vectors are coplanar, else set a flag
%%                  Find the largest angle between the vectors
%%                  Calculate the Taylor series for the answer
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  28 Mar 1990
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109  10 Oct 2001
%%
%%  Inputs        :
%%    R1          - IJK Position vector #1                 km
%%    R2          - IJK Position vector #2                 km
%%    R3          - IJK Position vector #3                 km
%%    JD1         - Julian Date of 1st sighting            Days from 4713 B.C.
%%    JD2         - Julian Date of 2nd sighting            Days from 4713 B.C.
%%    JD3         - Julian Date of 3rd sighting            Days from 4713 B.C.
%%
%%  OutPuts       :
%%    V2          - IJK Velocity Vector for R2             km / sec
%%    Theta       - Angle between vectors                  rad
%%    Error       - Flag indicating success                as above
%%
%%  Locals        :
%%    dt21        - time delta between r1 and r2           sec
%%    dt31        - time delta between r3 and r1           sec
%%    dt32        - time delta between r3 and r2           sec
%%    p           - P vector    r2 x r3
%%    PN          - P Unit Vector
%%    R1N         - R1 Unit Vector
%%    Theta1      - temporary Angle between vectors        rad
%%    TolAngle    - Tolerance angle  (10 deg)              rad
%%    Term1       - First Term for HGibbs expansion
%%    Term2       - Second Term for HGibbs expansion
%%    Term3       - Third Term for HGibbs expansion
%%    i           - Index
%%
%%  Constants     :
%%
%%  Coupling      :
%%    vecangle      Angle between two vectors
%%
%%  References    :
%%    Escobal       pg. 254-256, 304-306
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-

     global MU

     %%%%%%%%%%%%%%%%%%%%%%  Initialize values   %%%%%%%%%%%%%%%%%%%%-
     Error =  'ok';
     Theta =  0;
     R1mag = mag( R1 );
     R2mag = mag( R2 );
     R3mag = mag( R3 );
     V2 = [0;0;0];

     TolAngle= 0.174532925;
     dt21= (JD2-JD1) * 86400.0;
     dt31= (JD3-JD1) * 86400.0;   %% differences in times %%
     dt32= (JD3-JD2) * 86400.0;
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
     %%  Determine if the vectors are coplanar.  The dot product of R1 and the
     %%    normal vector of R2 and R3 will be 0 if all three vectors are coplanar.
     %%    The Vectors are normalized to accept very small and very large
     %%    vectors.  The magnitudes are left out of the dot product equation       :
     %%    r1n dot pn = r1n pn Cos()       : since each vector is normalized, so the
     %%    magnitudes are 1.0.  A 1 deg tolerance is allowed for estimation, and
     %%    is implemented by allowing the angle between R1n and Pn to range from
     %%    89.0 to 91.0 deg, or Cos(89.0) = 0.017452406.
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
     P = cross (R2 , R3);
     PN  = P/mag(P);
     R1N = R1/mag(R1);
     if abs( dot(R1N,PN) ) > 0.017452406 ,
         Error= 'not coplanar';
     else
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
     %% Check the size of the angles between the three position vectors.
     %%   Herrick Gibbs only gives "reasonable" answers when the
     %%   position vectors are reasonably close.  10 deg is only an estimate.
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
           Theta = vecangle ( R1,R2);
           Theta1 = vecangle ( R2,R3);
           if Theta1 > Theta ,
               Theta = Theta1;
           end
           if Theta > TolAngle ,
               Error = 'angle > 10ø';
           end

     %%%%%%%%%%%%%% Perform Herrick-Gibbs method to find V2 %%%%%%%%-

%           Term1= -dt32*( 1.0/(dt21*dt31) + MU/(12.0*R1mag*R1mag*R1mag) );
%           Term2= (dt32-dt21)*( 1.0/(dt21*dt32) + MU/(12.0*R2mag*R2mag*R2mag) );
%           Term3=  dt21*( 1.0/(dt32*dt31) + MU/(12.0*R3mag*R3mag*R3mag) );
           Term1= -dt32*( 1.0/(dt21*dt31) + MU/(12.0*R1mag^3) );
           Term2= (dt32-dt21)*( 1.0/(dt21*dt32) + MU/(12.0*R2mag^3) );
           Term3=  dt21*( 1.0/(dt32*dt31) + MU/(12.0*R3mag^3) );
           V2 = Term1 * R1 + Term2 * R2 + Term3 * R3;
     end   %% if not coplanar %%
