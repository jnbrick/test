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
## @deftypefn {} {@var{retval} =} Init_Struct (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2018-11-26

function Struct = Init_Struct ()
  % key assumptions
  %   path independent game (nonconfigurable) not really an assumption based on 
  %   "fair" game: player 1 and player 2 win the same way (configurable)
    Struct.fair=1;
    
    Struct.player=2;
    
    %"gains"
    
    Struct.gainwins=1;
    Struct.gaincats=0.5;
    Struct.gainloss=0;  
    Struct.lastturnbonus=0; %turns out this does nothing
    Struct.linereact=0;
    Struct.quadreact=0;
    Struct.switch2ml=1; %must be equal to or greater than 1
    
    
    
    Struct.currentgame=1;
  
    
  ##for i=1:3^9
    indeces=3^9;
    Struct.wins=zeros(1,indeces);
    Struct.cats=Struct.wins;
    Struct.loss=Struct.wins;
    
    
##    Struct.base{i}=sprintf('%06i',str2num(dec2base(i-1,3)));
  
##  endfor

endfunction
