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
## @deftypefn {} {@var{retval} =} analyze_board (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-11-27

function score = analyze_board (board,Struct)
  index = board2index (board);
  numgames=(Struct.wins(index)+Struct.cats(index)+Struct.loss(index));
  if numgames==0
    score=.5;
  else
    score = (Struct.gainwins*Struct.wins(index)+Struct.gaincats*Struct.cats(index)+Struct.gainloss*Struct.loss(index))/numgames;
  endif
  
  
endfunction
