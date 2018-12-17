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
## @deftypefn {} {@var{retval} =} TICTACTOE_board (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-11-26

function [board,flag] = TICTACTOE_play (board,x,y,player) 

board(x,y)=player;
flag=0;

if board(1,1)~=0&&board(1,1)==board(1,2)&&board(1,1)==board(1,3)
  %Top Row
  flag=board(1,1);
elseif board(2,1)~=0&&board(2,1)==board(2,2)&&board(2,1)==board(2,3)
  %Second Row
  flag=board(2,1);
elseif board(3,1)~=0&&board(3,1)==board(3,2)&&board(3,1)==board(3,3)
  %Third Row
  flag=board(3,1);
elseif board(1,1)~=0&&board(1,1)==board(2,1)&&board(1,1)==board(3,1)
  %First Column
  flag=board(1,1);
elseif board(1,2)~=0&&board(1,2)==board(2,2)&&board(1,2)==board(3,2)
  %Second Column
  flag=board(1,2);
elseif board(1,3)~=0&&board(1,3)==board(2,3)&&board(1,3)==board(3,3)
  %Third Column
  flag=board(1,3);
elseif board(1,1)~=0&&board(1,1)==board(2,2)&&board(1,1)==board(3,3)
  %Down Diaganol
  flag=board(1,1);
elseif board(3,1)~=0&&board(3,1)==board(2,2)&&board(3,1)==board(1,3)
  %Down Diaganol
  flag=board(3,1);
elseif prod(prod(board))~=0
  flag=-1;
endif




endfunction
