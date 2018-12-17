clear,clc

Fair=Init_Struct;
UnFair=Init_Struct;

UnFair.fair=1;
UnFair.player=1;


figure(1)
hold on
for i=1:1
##Fair=Init_Struct;

keepplaying=1;
ctr=0;
score=0;
style=0;
  stylectr=0;
while ctr<=1000000
  ctr=ctr+1;
  stylectr=stylectr+1;
  if stylectr>10
    stylectr=0;
    style=mod(style+1,2);
  endif
  
  
  turn=mod(ctr+1,2)+1;
  board=zeros(3,3);
  flag=0;
  while flag==0
    switch turn
      case 1
        if style==0
          [x,y,UnFair] = TICTACTOE_john (board,UnFair);
        elseif style==1
          [x,y] = TICTACTOE_rand (board);
        endif
        
      case 2
        [x,y,Fair] = TICTACTOE_john (board,Fair);
      otherwise
        error('not a valid case')
    endswitch
    
    [board,flag] = TICTACTOE_play (board,x,y,turn);
    turn=mod(turn,2)+1;
    board;
  endwhile
  flag;
  Fair = TICTACTOE_record (board,flag,Fair);
  if style==0
    UnFair = TICTACTOE_record (board,flag,UnFair);
  endif
  
  score(ctr)=score(end)+1*(flag==2)-1*(flag==1);
  score(end);
  
endwhile
i;
plot(score)
score(end)
endfor