function fprintvec(Where, VecName, Vec, Units, CoOrd)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use           : fprintvec(Where, VecName, Vec, Units, CoOrd)
%%
%%    Write formatted 3x1 vector to a file.
%%    This function writes out a line of a vector with units and I,J,K components
%%    plus its magnitude to a file. The formatting is fixed at 14.6f format.
%%
%%  Examples      :
%%
%%    fprintVec(1,'Vvec',V,'km/sec','SEZ') 
%%    prints the following to the screen
%%Vvec =       2.000000 S      3.000000 E      4.000000 Z, Mag =       5.385165(km/sec)
%%
%%    fprintVec(fid,'Vvec',V,'km/sec','SEZ') 
%%    prints the same to a file
%%
%%    fprintVec(1,'Vvec',V,'km/sec') 
%%    without the last parameter prints
%%Vvec =       2.000000 I      3.000000 J      4.000000 K, Mag =       5.385165(km/sec)
%%
%% Author        :  Dr Ron Lisowski  USAFA/DFAS  719-333-4109   2 JUL 2002
%%
%% Inputs        :
%%   Where       - The file ID. Set to 1 for screen output
%%   VecName     - a string with the description of the vector, e.g. 'V Vector' 
%%   Vec         - 3x1 vector to print
%%   Units       - a string with the units to print, e.g. 'km/sec'
%%   CoOrd       - a 3 character string of the coordinates to print,
%%                 e.g. 'SEZ', 'PQW', etc.This argument can be omitted in the call
%%                 which causes the default 'IJK' to print
%%
%% OutPuts       :
%%   None.
%%
%% Locals        :
%%   Coord       - Temporary variable for coordinate string
%%
%% Constants     :
%%   None.
%%
%% Coupling      :
%%   None.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

       if nargin > 4, 
          Coord = CoOrd;
       else
          Coord = 'IJK';
       end

       fprintf (Where,VecName); fprintf(Where,' = ' );
       fprintf (Where,'%14.6f',Vec(1)); fprintf (Where,[' ' Coord(1:1)]);
       fprintf (Where,'%14.6f',Vec(2)); fprintf (Where,[' ' Coord(2:2)]);
       fprintf (Where,'%14.6f',Vec(3)); fprintf (Where,[' ' Coord(3:3)]);
       fprintf (Where,', Mag = '); fprintf (Where,'%14.6f',norm(Vec));
       fprintf (Where,['(' Units ')\n']);
 
