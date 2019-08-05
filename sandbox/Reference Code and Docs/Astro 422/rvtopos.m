function [Rhovec, DRhovec] = rvtopos ( Rho,Az,El,DRho,DAz,DEl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use           : [Rhovec, DRhovec] = rvtopos ( Rho,Az,El,DRho,DAz,DEl)
%%
%%  This function finds range and velocity vectors for a satellite from a radar
%%    site in the Topocentric Horizon (SEZ) system.
%%
%%  Algorithm     : Assign temp values to limit number of trig operations
%%                  Find SEZ position vector and magnitude directly
%%                  Find SEZ velocity vector and magnitude directly
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
%%
%%  OutPuts       :
%%    RhoVec      - SEZ Satellite range vector             km
%%    DRhoVec     - SEZ Satellite velocity vector          km / sec
%%
%%  Locals        :
%%    SinEl       - Variable for sin( El )
%%    CosEl       - Variable for cos( El )
%%    SinAz       - Variable for sin( Az )
%%    CosAz       - Variable for cos( Az )
%%
%%  Constants     :
%%    None.
%%
%%  Coupling      : None.
%%
%%  References    :
%%    BMW           pg. 84 - 85
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-

     %%%%%%%%%%%%%%%%%%%%%%  Initialize values   %%%%%%%%%%%%%%%%%%%%-
     SinEl= sin(El);
     CosEl= cos(El);
     SinAz= sin(Az);
     CosAz= cos(Az);

     %%%%%%%%%%%%%%%%%%-  Form SEZ range vector  %%%%%%%%%%%%%%%%%%%%-
     Rhovec = Rho * [-CosEl*CosAz;  CosEl*SinAz; SinEl];

     %%%%%%%%%%%%%%%%%%  Form SEZ velocity vector  %%%%%%%%%%%%%%%%%%-
     DRhovec = [-DRho*CosEl*CosAz + Rho*SinEl*DEl*CosAz + Rho*CosEl*SinAz*DAz; ...
                 DRho*CosEl*SinAz - Rho*SinEl*DEl*SinAz + Rho*CosEl*CosAz*DAz; ...
                 DRho*SinEl       + Rho*DEl*CosEl];
