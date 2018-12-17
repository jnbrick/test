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
## @deftypefn {} {@var{retval} =} TICTACTOE_record (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-12-05

function Struct = TICTACTOE_record (board,flag,Struct)
  index = board2index (board);
  numturns=length(Struct.currentgame);
  if index~=Struct.currentgame(numturns)
    Struct.currentgame(numturns+1)=index;
  endif
  %should this be total games or games with this ending?
  numgames=(Struct.wins(index)+Struct.cats(index)+Struct.loss(index));
  number2add=1+Struct.linereact*numgames+Struct.quadreact*numgames^2;
  
  if flag==Struct.player %win
    Struct.wins(Struct.currentgame)=Struct.wins(Struct.currentgame)+number2add;
    Struct.wins(Struct.currentgame(end))=Struct.wins(Struct.currentgame(end))+Struct.lastturnbonus;
  elseif flag==mod(Struct.player,2)+1 %loss
    Struct.loss(Struct.currentgame)=Struct.loss(Struct.currentgame)+number2add;
    Struct.loss(Struct.currentgame(end))=Struct.loss(Struct.currentgame(end))+Struct.lastturnbonus;    
  elseif flag==-1 %tie
    Struct.cats(Struct.currentgame)=Struct.cats(Struct.currentgame)+number2add;
    Struct.cats(Struct.currentgame(end))=Struct.cats(Struct.currentgame(end))+Struct.lastturnbonus;
  else
    error('Johns code errored out')
  endif
  
  if Struct.fair==1 %opposite result if opposite board
    if flag~=-1
      flag=mod(flag,2)+1;
    end
    
    for i=1:length(Struct.currentgame)
      Struct.currentgame(i)=invertindex(Struct.currentgame(i));
    endfor
    
    if flag==Struct.player %win
      Struct.wins(Struct.currentgame)=Struct.wins(Struct.currentgame)+number2add;
      Struct.wins(Struct.currentgame(end))=Struct.wins(Struct.currentgame(end))+Struct.lastturnbonus;
    elseif flag==mod(Struct.player,2)+1 %loss
      Struct.loss(Struct.currentgame)=Struct.loss(Struct.currentgame)+number2add;
      Struct.loss(Struct.currentgame(end))=Struct.loss(Struct.currentgame(end))+Struct.lastturnbonus;    
    elseif flag==-1 %tie
      Struct.cats(Struct.currentgame)=Struct.cats(Struct.currentgame)+number2add;
      Struct.cats(Struct.currentgame(end))=Struct.cats(Struct.currentgame(end))+Struct.lastturnbonus;
    else
      error('Johns code errored out')
    endif    
      
  endif
  Struct.currentgame=[];
  Struct.currentgame=1;
   
    
  
  
  
    
endfunction
