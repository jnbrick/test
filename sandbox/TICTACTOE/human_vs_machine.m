##clear,clc
##
##Struct=Init_Struct;

keepplaying=1;
ctr=0;
while keepplaying==1
  ctr=ctr+1;
  turn=mod(ctr+1,2)+1;
  board=zeros(3,3)
  flag=0;
  while flag==0
    switch turn
      case 1
        keyboard
        x=row;
        y=col;
      case 2
        [x,y,Struct] = TICTACTOE_john (board,Struct);
      otherwise
        error('not a valid case')
    endswitch
    
    [board,flag] = TICTACTOE_play (board,x,y,turn);
    turn=mod(turn,2)+1;
    board
  endwhile
  flag
  Struct = TICTACTOE_record (board,flag,Struct);
  
endwhile
