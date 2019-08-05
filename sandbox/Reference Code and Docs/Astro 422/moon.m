function [RMoon, RtAsc, Decl] = moon ( JD)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-
%%
%%  Use           : [RMoon, RtAsc, Decl] = moon ( JD)
%%
%%  This function calculates the Geocentric Equatorial (IJK) position vector
%%    for the moon given the Julian Date.  This is the low precision formula and
%%    is valid for years between 1950 and 2050.  Notice many of the calculations
%%    are performed in degrees.  This coincides with the development in the
%%    Almanac.  A few equations were split in two to prevent software problems
%%    with numeric coprocessors. The program accuracies are as follows:
%%
%%                 Eclpitic Longitude  0.3   deg
%%                 Eclpitic Latitude   0.2   deg
%%                 Horiz Parallax      0.003 deg
%%                 Distance from Earth 0.2   Earth radii
%%                 Right Ascension     0.3   deg
%%                 Declination         0.2   deg
%%
%%  Algorithm     : Find the initial quantities
%%                  Calculate direction cosines
%%                  Find the position and velocity vector
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-472-4109  25 Aug 1988
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-472-4110  12 Oct 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109  10 Oct 2001
%%
%%  Inputs        :
%%    JD          - Julian Date                            days from 4713 B.C.
%%
%%  Outputs       :
%%    RMoon       - IJK Position vector of the Moon        km
%%    RtAsc       - Right Ascension                        rad
%%    Decl        - Declination                            rad
%%
%%  Locals        :
%%    EclpLong    - Ecliptic Longitude
%%    EclpLat     - Eclpitic Latitude
%%    HzParal     - Horizontal Parallax
%%    l           - Geocentric Direction Cosines
%%    m           -             "     "
%%    n           -             "     "
%%    Tu          - Julian Centuries from 1 Jan 1900
%%    x           - Temporary REAL variable
%%
%%  Constants     :
%%    TwoPI       -                                        6.28318530717959
%%    Rad         - Radians per Degrees                   1.0/57.29577951308230
%%
%%  Coupling      :
%%    None.
%%
%%  References    :
%%    1987 Astronomical Almanac Pg. D46
%%    Explanatory Supplement( 1960 ) pg. 106-111
%%    Roy, Orbital Motion Pg. 61-62 ( Discussion of parallaxes )
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-


%%   CONSTANTS
     global TwoPI Rad RE

     %%%%%%%%%%%%%%%%%%%%%%  Initialize values   %%%%%%%%%%%%%%%%%%%%-
     Tu = ( JD - 2451545.0 ) / 36525.0;

     x  =   218.32 + 481267.883*Tu ...
                  + 6.29*sin( (134.9+477198.85*Tu)*Rad ) ...
                  - 1.27*sin( (259.2-413335.38*Tu)*Rad ) ...
                  + 0.66*sin( (235.7+890534.23*Tu)*Rad );

     EclpLong= x + 0.21*sin( (269.9+954397.70*Tu)*Rad ) ...
                  - 0.19*sin( (357.5+ 35999.05*Tu)*Rad ) ...
                  - 0.11*sin( (186.6+966404.05*Tu)*Rad );   %% Deg %%

     EclpLat =     5.13*sin( ( 93.3+483202.03*Tu)*Rad ) ...
                  + 0.28*sin( (228.2+960400.87*Tu)*Rad ) ...
                  - 0.28*sin( (318.3+  6003.18*Tu)*Rad ) ...
                  - 0.17*sin( (217.6-407332.20*Tu)*Rad );     %% Deg %%

     x =    0.9508 + 0.0518*cos( (134.9+477198.85*Tu)*Rad );

     HzParal = x + 0.0095*cos( (259.2-413335.38*Tu)*Rad ) ...
                  + 0.0078*cos( (235.7+890534.23*Tu)*Rad ) ...
                  + 0.0028*cos( (269.9+954397.70*Tu)*Rad );   %% Deg %%

     EclpLong = revcheck(EclpLong*Rad, TwoPI)  ;
     EclpLat  = revcheck(EclpLat*Rad, TwoPI)   ;
     HzParal  = revcheck(HzParal*Rad, TwoPI)   ;

     %%%%%%%%%%%%%%- Find the geocentric direction cosines %%%%%%%%%%-
     l= cos( EclpLat ) * cos( EclpLong );
     m= 0.9175*cos(EclpLat)*sin(EclpLong) - 0.3978*sin(EclpLat);
     n= 0.3978*cos(EclpLat)*sin(EclpLong) + 0.9175*sin(EclpLat);

     %%%%%%%%%%%%%%%% Calculate Moon position vector %%%%%%%%%%%%%%%%-
     RMoon = (RE / sin( HzParal ))*[l; m; n];

     %%%%%%%%%%%%%%%%- Find Rt Ascension and Declination %%%%%%%%%%%%-
     RtAsc= atan2( m,l );
     Decl= atan( n );
