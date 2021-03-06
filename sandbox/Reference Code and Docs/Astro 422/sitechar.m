function [Lat, Lon, Alt, Bias_Rho, Bias_Az, Bias_El, Sigma_Rho, Sigma_Az, Sigma_El] ...
                = sitechar ( Tracker_Num )
%%  Use           : [Lat, Lon, Alt, Bias_Rho, Bias_Az, Bias_El, Sigma_Rho, Sigma_Az, Sigma_El] ...
%%              = sitechar ( Tracker_Num )
%%  This procedure contains the characteristics on the various US satellite sensors.
%%   The input is the sensor number and the outputs are the necessary characteristics.

                                %%  ASTRO 422  %%

                     %%  Satellite Sensor Characteristics %%

                              %%   Capt Vallado %%
                           %%   in Ada Dr Lisowski %%

%%The following lines list the charcteristics for most US sensors.  The format of
%%each station is the same, and is listed below.

%%a 211
%%  33.81724 -106.66030, 1510.2
%%b                        %% GEODSS-SOCORRO %%           0.000, 90.000, 6
%%c%%       Range           Azimuth         Elevation      BoreSight 
%%d    100.00,  92600.00,  0.00,  360.00, 20.00,   90.00,   90.00)  ; %% Search
%%e    100.00,  92600.00,  0.00,  360.00,  5.00,   90.00,   90.00)  ; %% Track 
%%f   9999.00,             0.0017          0.0010)                  ; %% Bias 
%%g   9999.00,             0.0033          0.0027                   ; %% Noise 
%%

%%Line a - Sensor number, Latitude in deg, Longitude in deg, Altitude in m
%%Line b - Sensor name
%%Line c - Titles
%%Line d - Search values for Min & Max Range in km, Azimuth in deg, Elevation in deg
%%Line e - Track  values for Min & Max Range in km, Azimuth in deg, Elevation in deg
%%Line f - Bias   values for Range in m, Azimuth in deg, Elevation in deg
%%Line g - Noise  standard deviations for Range in m, Azimuth in deg, Elevation in deg
%%
%%                       Satellite Sensor Characteristics


%%DEEP SPACE ELECTRO-OPTICAL
   switch Tracker_Num

   case  211,
 a = [ ...
   33.81724, -106.66030, 1510.2 ];
                        %% GEODSS-SOCORRO %%           0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight 
 d = [ ...
    100.00,  92600.00,  0.00,  360.00, 20.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,  92600.00,  0.00,  360.00,  5.00,   90.00,   90.00]  ; %% Track
 f = [ ...
   9999.00,             0.0017,          0.0010]                 ; %% Bias
 g = [ ...
   9999.00,             0.0033,          0.0027]                 ; %% Noise

   case   221,
 a = [ ...
  35.74405,  128.60787,  784.2  ];
                        %% GEODSS-TAEGU %%             0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight 
 d = [ ...
    100.00,  92600.00,  0.00,  360.00, 20.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,  92600.00,  0.00,  360.00,  5.00,   90.00,   90.00]  ; %% Track
 f = [ ...
   9999.00,             0.0023,          0.0010]                 ; %% Bias
 g = [ ...
   9999.00,             0.0023,          0.0020]                 ; %% Noise

   case   231,
    a = [ ...
  20.70801, -156.25794,  3058.6 ];
                        %% GEODSS-MAUI %%              0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight 
 d = [ ...
    100.00,  92600.00,  0.00,  360.00, 20.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,  92600.00,  0.00,  360.00,  5.00,   90.00,   90.00]  ; %% Track
 f = [ ...
   9999.00,             0.0023,          0.0017]                 ; %% Bias
 g = [ ...
   9999.00,             0.0037,          0.0030]                 ; %% Noise

   case   241,
   a = [ ...
  -7.41165,   72.45191,  -61.1 ];
                        %% GEODSS-DIEGO GARCIA %%      0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight 
 d = [ ...
    100.00,  92600.00,  0.00,  360.00, 20.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,  92600.00,  0.00,  360.00,  5.00,   90.00,   90.00]  ; %% Track
 f = [ ...
   9999.00,             0.0017,          0.0023]                 ; %% Bias
 g = [ ...
   9999.00,             0.0043,          0.0043]                 ; %% Noise


%%DEEP SPACE RADAR TRACKER

   case   369,
   a = [ ...
  42.61740, -71.49105,  123.1 ];
                        %% MILLSTONE %%                0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    300.00,  40744.00,  0.00,  360.00,  0.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    300.00,  40744.00,  0.00,  360.00,  0.00,   90.00,   90.00]  ; %% Track
 f = [ ...
    150.00,             0.0001,         0.0001]                  ; %% Bias
 g = [ ...
    150.00,             0.0100,         0.0100]                  ; %% Noise


%%DEEP SPACE OPTICAL - BAKER NUNN

   case    27,
   a = [ ...
   46.89944,  -65.21020, 26.2 ];
                        %% St Margrets %%              0.000,  0.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
      0.00,      0.00,  0.00,    0.00,  0.00,    0.00,    0.00]  ;
       %% Search
    e = [ ...
      0.00,      0.00,  0.00,    0.00,  0.00,    0.00,    0.00]  ; %% Track
   f = [ ...
      0.00,             0.00,           0.00]                    ; %% Bias
 g = [ ...
      0.00,             0.00,           0.00]                    ; %% Noise

   case    28,
   a = [ ...
   40.64095,   17.84558,  35.8 ];
                        %% San Vito %%                 0.000,  0.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
      0.00,      0.00,  0.00,    0.00,  0.00,    0.00,    0.00]  ; %% Search
 e = [ ...
      0.00,      0.00,  0.00,    0.00,  0.00,    0.00,    0.00]  ; %% Track
 f = [ ...
      0.00,             0.00,           0.00]                    ; %% Bias
 g = [ ...
      0.00,             0.00,           0.00]                    ; %% Noise

%%NEAR EARTH RADAR TRACKER

   case   331,
   a = [ ...
  15.25000, 145.79000, 0.0   ];
                        %% SAIPAN %%                   0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   4630.00,  0.00,  360.00,  2.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   4630.00,  0.00,  360.00,  2.00,   90.00,   90.00]  ; %% Track
 f = [ ...
     92.04,             0.0130,         0.0090]                  ; %% Bias
 g = [ ...
    102.00,             0.0280,         0.0250]                  ; %% Noise

   case   334,
   a = [ ...
   9.39539,  167.47913,  62.7  ];
                        %% ALTAIR %%                   0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   4500.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   4500.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Track
 f = [ ...
    108.00,             0.0140,         0.0161]                  ; %% Bias
 g = [ ...
    162.90,             0.0318,         0.0129]                  ; %% Noise

   case   337,
   a = [ ...
  37.90521,   39.99319,  890.0 ];
                        %% PIRINCLIK %%                0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5100.00,  0.00,  360.00,  2.00,   86.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   5100.00,  0.00,  360.00,  2.00,   86.00,   90.00]  ; %% Track
 f = [ ...
    409.00,             0.0264,         0.0193]                  ; %% Bias
 g = [ ...
     38.80,             0.0337,         0.0290]                  ; %% Noise

   case   342,
   a = [ ...
  54.36715,   -0.66682,  301.5 ];
                        %% FYLINGDALES %%              0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   4820.00,285.00,  189.00,  4.00,   70.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   4820.00,285.00,  189.00,  4.00,   70.00,   90.00]  ; %% Track
 f = [ ...
   2253.00,             0.0690,         0.0255]                  ; %% Bias
 g = [ ...
   2199.00,             0.1034,         0.0364]                  ; %% Noise

   case   346,
   a = [ ...
  15.00080, 120.06960, 68.8  ];
                        %% SAN MIGUEL %%               0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   3190.00,  0.00,  360.00,  1.00,   88.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   3190.00,  0.00,  360.00,  1.00,   88.00,   90.00]  ; %% Track
 f = [ ...
     87.10,             0.0381,         0.0190]                  ; %% Bias
 g = [ ...
     68.70,             0.0315,         0.0433]                  ; %% Noise

   case   354,
   a = [ ...
  -7.90668,  -14.40265,  56.1  ];
                        %% ASCENSION %%                0.000, 90.000,30
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   1600.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   1900.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Track
 f = [ ...
     92.20,             0.0133,         0.0085]                  ; %% Bias
 g = [ ...
    101.70,             0.0283,         0.0248]                  ; %% Noise

   case   359,
   a = [ ...
  64.29115, -149.19298,  213.3 ];
                        %% CLEAR %%                    0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   4910.00,170.00,  110.00,  1.50,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   4910.00,170.00,  110.00,  1.50,   90.00,   90.00]  ; %% Track
 f = [ ...
    153.20,             0.0355,          0.0171]                 ; %% Bias
 g = [ ...
     62.50,             0.0791,          0.0240]                 ; %% Noise

   case   363,
   a = [ ...
  17.14360, -61.79267,  0.5   ];
                        %% ANTIGUA %%                  0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   2550.00,  0.00,  360.00,  0.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   2550.00,  0.00,  360.00,  0.00,   90.00,   90.00]  ; %% Track
 f = [ ...
     80.00,             0.0081,         0.0045]                  ; %% Bias
 g = [ ...
     92.50,             0.0224,         0.0139]                  ; %% Noise

   case   932,
   a = [ ...
  21.57208, -158.26674,  300.2 ];
                        %% KAENA POINT %%              0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   6380.00,  0.00,  360.00,  0.00,  180.00,   90.00]  ; %% Search
 e = [ ...
    100.00,   6380.00,  0.00,  360.00,  0.00,  180.00,   90.00]  ; %% Track
 f = [ ...
     80.00,             0.0081,         0.0045]                  ; %% Bias
 g = [ ...
     92.50,             0.0224,         0.0139]                  ; %% Noise

%%NEAR EARTH PHASED ARRAY

   case   382,
   a = [ ...
  30.97826, -100.55298,  774.2 ];
                        %% PPSWSE FACE ELD %%            130.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00, 70.00,  190.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00, 70.00,  190.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   383,
   a = [ ...
  30.97826, -100.55298,  774.2 ];
                        %% PPSWSW FACE ELD %%            250.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,190.00,  310.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,190.00,  310.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   384,
   a = [ ...
  32.58123,  -83.56936,  86.3  ];
                        %% PPSENE FACE ROB %%             70.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00, 10.00,  130.00,  3.00,   85.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00, 10.00,  130.00,  3.00,   85.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   385,
   a = [ ...
  32.58123,  -83.56936,  86.3  ];
                        %% PPSES FACE ROB %%             190.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,130.00,  250.00,  3.00,   85.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,130.00,  250.00,  3.00,   85.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   386,
   a = [ ...
  41.75242,  -70.53827,  80.3  ];
                        %% PPENE FACE COD %%              47.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,347.00,  107.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,347.00,  107.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   387,
   a = [ ...
  41.75242,  -70.53827,  80.3  ];
                        %% PPESE FACE COD %%             167.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,107.00,  227.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,107.00,  227.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   388,
   a = [ ...
  39.13604, -121.35087,  115.7 ];
                        %% PPWS FACE BLE %%              186.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,126.00,  246.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,126.00,  246.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     92.00,             0.0160,         0.0130]                  ; %% Bias
 g = [ ...
     35.00,             0.0320,         0.0330]                  ; %% Noise

   case   389,
   a = [ ...
  39.13604, -121.35087,  115.7 ];
                        %% PPWNW FACE BLE %%             306.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,246.00,    6.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,246.00,    6.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     92.00,             0.0160,         0.0130]                  ; %% Bias
 g = [ ...
     35.00,             0.0320,         0.0330]                  ; %% Noise

   case   393,
   a = [ ...
  52.73726,  174.09093,  91.2  ];
                        %% COBRA DANE %%             319.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    463.00,   4500.00,259.00,   19.00,  0.60,   80.00,   60.00]  ; %% Search
 e = [ ...
    463.00,   4500.00,259.00,   19.00,  0.60,   80.00,   60.00]  ; %% Track
 f = [ ...
     41.70,             0.0067,         0.0084]                  ; %% Bias
 g = [ ...
     20.80,             0.0303,         0.0210]                  ; %% Noise

   case   394,
   a = [ ...
  76.57029,  -68.29923,  424.7 ];
                        %% THULESE FACE %%           117.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00, 57.00,  177.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00, 57.00,  177.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   395,
   a = [ ...
  76.57029,  -68.29923,  424.7 ];
                        %% THULEN FACE %%            357.000, 20.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   5555.00,297.00,   57.00,  3.00,   80.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   5555.00,297.00,   57.00,  3.00,   80.00,   60.00]  ; %% Track
 f = [ ...
     70.80,             0.0130,         0.0075]                  ; %% Bias
 g = [ ...
     26.00,             0.0260,         0.0220]                  ; %% Noise

   case   396,
   a = [ ...
  48.72479,  -97.89974,  347.3 ];
                        %% PARCS %%                    8.000, 25.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,   3300.00,313.00,   62.00,  1.90,   45.00,   60.00]  ; %% Search
 e = [ ...
    100.00,   3300.00,298.00,   78.00,  1.90,   95.00,   60.00]  ; %% Track
 f = [ ...
     49.90,             0.0036,          0.0038]                 ; %% Bias
 g = [ ...
     28.00,             0.0125,          0.0086]                 ; %% Noise

   case   399,
   a = [ ...
  30.57242,  -86.21485,  34.7  ];
                        %% EGLIN %%                  180.000, 45.000,10
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    100.00,  13210.00,145.00,  215.00,  1.00,  105.00,   60.00]  ; %% Search
 e = [ ...
    100.00,  13210.00,120.00,  240.00,  1.00,  105.00,   60.00]  ; %% Track
 f = [ ...
      4.30,             0.0100,         0.0094]                  ; %% Bias
 g = [ ...
     32.10,             0.0154,         0.0147]                  ; %% Noise



%%NEAR EARTH RADAR INTERFEROMETER

   case   745,
   a = [ ...
  33.55396,  -98.76306,  305.3 ];
                        %% NAVSPASUR %%                0.000,  0.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
      0.00,   8150.00, 90.00,  270.00, -7.50,   -7.60,    0.00]  ; %% Search
 e = [ ...
      0.00,   8150.00, 90.00,  270.00, -7.50,   -7.60,    0.00]  ; %% Track
   f = [ ...
    436.81,             0.0110,         0.0140]                  ; %% Bias
 g = [ ...
   1905.00,             0.0396,         0.0445]                  ; %% Noise

%%OTHER

   case  6002,
   a = [ ...
 -1.71000,  36.50000, 0.0 ];
                        %% NAIROBI %%                  0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    300.00,  40000.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    300.00,  40000.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Track
 f = [ ...
    150.00,             0.0001,         0.0001]                  ; %% Bias
 g = [ ...
    150.00,             0.0100,         0.0100]                  ; %% Noise

   case  6003,
   a = [ ...
 -4.80000,  55.50000, 0.0 ];
                        %% MAHE ISLAND %%              0.000, 90.000, 6
%%       Range           Azimuth         Elevation      BoreSight
 d = [ ...
    300.00,  40000.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Search
 e = [ ...
    300.00,  40000.00,  0.00,  360.00,  1.00,   90.00,   90.00]  ; %% Track
 f = [ ...
    150.00,             0.0001,         0.0001]                  ; %% Bias
 g = [ ...
    150.00,             0.0100,         0.0100]                  ; %% Noise

   otherwise

         disp (' Satellite Tracker Number '); disp ( Tracker_Num);
           disp ('    is not on file');

   end %case

   Lat = a(1);
   Lon = a(2);
   Alt = a(3);

   Bias_Rho = f(1);
   Bias_Az  = f(2);
   Bias_El  = f(3);

   Sigma_Rho = g(1);
   Sigma_Az  = g(2);
   Sigma_El  = g(3);

