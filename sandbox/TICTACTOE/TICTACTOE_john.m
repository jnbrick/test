## Copyright (C) 2018 John
## 
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} TICTACTOE_rand (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-11-26

function [x,y,Struct] = TICTACTOE_john (board,Struct)
  %append current index to current game
  numturns=length(Struct.currentgame);
  currentindex=board2index (board);
  if currentindex==1
    numturns=0;
  end
  Struct.currentgame(numturns+1) = currentindex;
  
  [X,Y]=find(board==0);
if sum([Struct.wins(1),Struct.cats(1),Struct.loss(1)])<=Struct.switch2ml
  
  i=randi(length(X));
  
  x=X(i);
  y=Y(i);
##  disp('random')
  
else
  for i = 1:length(X)
    testboard=board;
    testboard(X(i),Y(i))=Struct.player;
    score(i) = analyze_board (testboard,Struct);
  endfor
  [maxscore,~]=max(score);
  COAs=find(score==maxscore);
  i=randi(length(COAs));
  if length(COAs)>1
##    disp('random')
  endif
  x=X(COAs(i));
  y=Y(COAs(i));
endif

plannedboard=board;
plannedboard(x,y)=Struct.player;
Struct.currentgame(numturns+2) = board2index (plannedboard);
    
endfunction
