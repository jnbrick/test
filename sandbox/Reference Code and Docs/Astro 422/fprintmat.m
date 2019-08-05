function fprintmat (ToWhere, Mat1, Title)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%  Use           : fprintmat (ToWhere, Mat1, Title)
%%
%%  This procedure prints a matrix.
%%
%%  Algorithm     : Write out the title for the matrix, loop
%%                  through the rows and print out 1 row at a time. The 
%%                  dimensions of the matrix are use for the loop ranges.
%%
%%  Author        : Capt Dave Vallado  USAFA/DFAS  719-333-4109   11 Oct 1989
%%  In Ada        : Dr Ron Lisowski    USAFA/DFAS  719-333-4109   14 Dec 1995
%%  In MatLab     : Dr Ron Lisowski    USAFA/DFAS  719-333-4109    1 Apr 2002
%%
%%  Inputs        :
%%    Mat1        - Matrix to print out
%%    DecNum      - Number of decimals to write
%%
%%  OutPuts       :
%%    None.
%%
%%  Locals        :
%%    Row         - Row Index
%%    Col         - Column Index
%%
%%  Coupling      :
%%    None.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     [NRow, NCol] = size (Mat1);
     fprintf (ToWhere, [Title   '\n']);
     for Row = 1:NRow ,
         for Col = 1:NCol ,
             fprintf(ToWhere, ' ');
             fprintf(ToWhere,'%13.5e' ,Mat1(Row,Col));
             if (mod (Col, 6) == 0) && (NCol > 6) ,
                 fprintf(ToWhere, '\n ');
             end;
          end ; %% on Col
         fprintf(ToWhere, '\n');
     end ; %% on Row
