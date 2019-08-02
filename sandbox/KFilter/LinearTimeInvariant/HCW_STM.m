## Copyright (C) 2019 John
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
## @deftypefn {} {@var{retval} =} HCW_STM (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2019-07-14

function STM = HCW_STM (n,t)
	N=n*t;
	sin_nt=sin(n*t);
	cos_nt=cos(n*t);
	STM	=[
		4-3*cos_nt		0	0			1/n*sin_nt		2/n*(1-cos_nt)		0
		6*(sin_nt-N)	1	0			2/n*(cos_nt-1)	1/n*(4*sin_nt-3*N)	0
		0				0	cos_nt		0				0					1/n*sin_nt
		3*n*sin_nt 		0	0			cos_nt			2*sin_nt			0
		6*n*(cos_nt-1)	0	0			-2*sin_nt		4*cos_nt-3			0
		0				0	-n*sin_nt	0				0					cos_nt
		];
	

endfunction
