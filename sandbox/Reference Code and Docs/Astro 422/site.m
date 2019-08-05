function [RS,VS] = site ( Lat,Alt,Lst)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use           : [RS,VS] = site ( Lat,Alt,Lst)
%
%%  This function finds the position and velocity vectors for a site.  The
%%    answer is returned in the Geocentric Equatorial (IJK) coordinate system.
%%
%%  Algorithm     : Set up constants
%%                  Find x and z values
%%                  Find position vector directly
%%                  Call cross to find the velocity vector
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  12 Aug 1988
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  17 May 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109  10 Oct 2001
%%
%%  Inputs        :
%%    Lat         - Geodetic Latitude                      -Pi/2 to Pi/2 rad
%%    Alt         - Altitude                               km
%%    LST         - Local Sidereal Time                    -2Pi to 2Pi rad
%%
%%  OutPuts       :
%%    RS          - IJK Site position vector               km
%%    VS          - IJK Site velocity vector               km/sec
%%
%%  Locals        :
%%    EarthRate   - IJK Earth's rotation rate vector       rad/sec
%%    SinLat      - Variable containing  sin( Lat )        rad
%%    Temp        - Temporary Real value
%%    x           - x component of site vector             km
%%    z           - z component of site vector             km
%%
%%  Constants     :
%%    EESqrd      - Eccentricity of Earth's shape sqrd
%%    OmegaEarth  - Angular rotation of Earth (Rad/TU)
%%
%%  Coupling      : None.
%% 
%%  References    :
%%    Escobal       pg. 26 - 29  (includes Geocentric Lat formulation also)
%%    Kaplan        pg. 334-336
%%    BMW           pg. 94 - 98
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-

%% CONSTANTS
   global RE EEsqrd OmegaEarth

     %%%%%%%%%%%%%%%%%%%%%%  Initialize values   %%%%%%%%%%%%%%%%%%%%-
     AEarth = RE;
     SinLat      = sin( Lat );
     Earthrate = [0.0; 0.0; OmegaEarth];

     %%%%%%%%%%-  Find x and z components of site vector  %%%%%%%%%%%%
     Temp  = sqrt( 1.0 - ( EEsqrd*SinLat*SinLat ) );
     x     = ( ( AEarth/Temp ) + Alt )*cos( Lat );
     z     = ( ( AEarth * (1.0-EEsqrd)/Temp) + Alt )*SinLat;

     %%%%%%%%%%%%%%%%%%  Find Site position vector  %%%%%%%%%%%%%%%%%%
     RS = [x * cos( Lst ); x * sin( Lst ); z];

     %%%%%%%%%%%%%%%%%%  Find Site velocity vector  %%%%%%%%%%%%%%%%%%
     VS = cross(Earthrate, RS);

