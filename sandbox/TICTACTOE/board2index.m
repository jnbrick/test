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
## @deftypefn {} {@var{retval} =} board2index (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-11-28

function index = board2index (board)
  board_length=9;
  flat_board=reshape(board,[1,board_length]);
  comb_board=0;
  for i=1:board_length
    comb_board=comb_board+flat_board(i)*10^(board_length-i);
  end
  
  index=base2dec(num2str(comb_board),3)+1;
endfunction
