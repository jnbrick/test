function [R, V] = track ( Rho,Az,El,DRho,DAz,DEl,Lat,Lst, RS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use           : [R, V] = track ( Rho,Az,El,DRho,DAz,DEl,Lat,Lst, RS)
%%
%%  This function finds range and velocity vectors in the Geocentric Equatorial
%%    (IJK) system given the following input from a radar site.
%%
%%  Algorithm     : Find constant values
%%                  Find SEZ vectors from RVToPOS
%%                  Rotate to find IJK vectors
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  12 Aug 1988
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109  10 Oct 2001
%%
%%  Inputs        :
%%    Rho         - Satellite range from site              km
%%    Az          - Azimuth                                0.0 to 2Pi rad
%%    El          - Elevation                              -Pi/2 to Pi/2 rad
%%    DRho        - Range Rate                             km / sec
%%    DAz         - Azimuth Rate                           rad / sec
%%    DEl         - Elevation rate                         rad / sec
%%    Lat         - Geodetic Latitude                      -Pi/2 to Pi/2 rad
%%    LST         - Local Sidereal Time                    -2Pi to 2Pi rad
%%    RS          - IJK Site position vector               km
%%
%%  OutPuts       :
%%    R           - IJK Satellite position vector          km
%%    V           - IJK Satellite velocity vector          km / sec
%%
%%  Locals        :
%%    WCrossR     - Cross product result                   km / sec
%%    RhoVec      - SEZ range vector from site             km
%%    DRhoVec     - SEZ velocity vector from site          km / sec
%%    TempVec     - Temporary vector
%%    RhoV        - IJK range vector from site             km
%%    DRhoV       - IJK velocity vector from site          km / sec
%%    EarthRate   - IJK Earth's rotation rate vector       rad / sec
%%
%%  Constants     :
%%    HalfPi      - Pi/2
%%    OmegaEarth  - Angular rotation of Earth (Rad/sec)
%%
%%  Coupling      :
%%    rvtopos       Find R and V from site in Topocentric Horizon (SEZ) system
%%    axisrot       Euler angle rotation about an axis
%%
%%  References    :
%%    BMW           pg. 85-89, 100-101
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% CONSTANTS
    global HalfPI OmegaEarth

     %%%%%%%%%%%%%%%%%%%%%%  Initialize values   %%%%%%%%%%%%%%%%%%%%-
     Earthrate = [0.0; 0.0; OmegaEarth];

     %%%%%%%%%%%%-  Find SEZ range and velocity vectors %%%%%%%%%%%%%%
     [RhoVec,DRhoVec] = rvtopos( Rho,Az,El,DRho,DAz,DEl );

     %%%%%%%%%%%%%%  Perform SEZ to IJK transformation %%%%%%%%%%%%%%-
     RhoV  = axisrot( axisrot( RhoVec, 2, Lat-HalfPI), 3,-Lst);
     DRhoV = axisrot( axisrot( DRhoVec, 2, Lat-HalfPI), 3,-Lst);

     %%%%%%%%%%%%-  Find IJK range and velocity vectors %%%%%%%%%%%%%%
     R = RhoV + RS;
     V = DRhoV + cross (Earthrate, R);
