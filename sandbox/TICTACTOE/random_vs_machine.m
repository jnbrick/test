##clear,clc
##close all

linereact=[0];
quadreact=[0];

Ngames=100000;
Nruns=1;

tic
totctr=0;
for k=1:length(linereact)
  
for j=1:length(quadreact)

for i=1:Nruns
##  Struct = Init_Struct ();
  
  Struct.linereact=linereact(k);
  Struct.quadreact=quadreact(j);
  
keepplaying=1;
ctr=0;
score=0;
while ctr<Ngames
  ctr=ctr+1
  turn=mod(ctr+1,2)+1;
  board=zeros(3,3);
  flag=0;
  while flag==0
    switch turn
      case 1
        [x,y] = TICTACTOE_rand (board);
      case 2
        [x,y,Struct] = TICTACTOE_john (board,Struct);
      otherwise
        error('not a valid case')
    endswitch
    
    [board,flag] = TICTACTOE_play (board,x,y,turn);
    turn=mod(turn,2)+1;
  endwhile
  Struct = TICTACTOE_record (board,flag,Struct);
  score(ctr)=score(end)+1*(flag==2)-1*(flag==1);  
endwhile

  totctr=totctr+1
  tot_kji(totctr,:)=[k,j,i];
  totscore(totctr)=score(end);

endfor %i loop

endfor %j loop

endfor %k loop

toc