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
## @deftypefn {} {@var{retval} =} index2board (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-12-05

function board = index2board (index)
  board_string=sprintf('%09i',str2num(dec2base(index-1,3)));
  for i=1:length(board_string)
    flat_board(i)=str2num(board_string(i));
  endfor
  board=reshape(flat_board,[3,3]);
endfunction
