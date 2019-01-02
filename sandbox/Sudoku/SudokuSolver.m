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
## @deftypefn {} {@var{retval} =} SudokuSolver (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: John <John@PC>
## Created: 2019-01-02

function board = SudokuSolver (board)
  
  [row,col]=find(board==0);
  cellsleft=length(row);
  cellcouldbe=ones(9,9,9);
  
  [solvrow,solvcol]=find(board);
  for i=1:length(solvrow)
    cellcouldbe(solvrow(i),solvcol(i),:)=0;
  endfor
  
  
  while cellsleft>0
    
    
    %Identify the possibilities for each cell
    for i=1:cellsleft
      chkexclus=find(cellcouldbe(row(i),col(i),:)==1);
      group1=board(row(i),:);
      group2=board(:,col(i))';
      rowgroup=floor((row(i)-1)/3);
      colgroup=floor((col(i)-1)/3);
      group3=board(rowgroup*3+1:rowgroup*3+3,colgroup*3+1:colgroup*3+3);
      box(i)=(rowgroup)*3+colgroup+1;
      for j=1:length(chkexclus)
        if sum([group1==chkexclus(j),group2==chkexclus(j),sum(group3==chkexclus(j))])>0
          cellcouldbe(row(i),col(i),chkexclus(j))=0;
        endif
      endfor
      if sum(cellcouldbe(row(i),col(i),:))==1
        board(row(i),col(i))=find(cellcouldbe(row(i),col(i),:)==1)
      endif
      
      
    endfor
    unsolvrow=unique(row);
    unsolvcol=unique(col);
    unsolvbox=unique(box);
    
    
    %walk through each group and identify if there is only one solution in a group
    
    for i=1:length(unsolvrow)
      for j=1:9
        group2inspect=cellcouldbe(unsolvrow(i),:,j);  
        if sum(group2inspect)==1
          index2change=find(group2inspect);
          board(unsolvrow(i),index2change)=j
          cellcouldbe(unsolvrow(i),index2change,j)=0;
          keyboard
        endif
      endfor
    endfor
    
    for i=1:length(unsolvcol)
      for j=1:9
        group2inspect=cellcouldbe(:,unsolvcol(i),j);  
        if sum(group2inspect)==1
          index2change=find(group2inspect);
          board(index2change,unsolvcol(i))=j
          cellcouldbe(index2change,unsolvcol(i),j)=0;
          keyboard
        endif
      endfor
    endfor
    
    for i=1:length(unsolvbox)
      for j=1:9
        rowgroup=floor((unsolvbox(i)-1)/3);
        colgroup=mod(unsolvbox(i),3);
        group2inspect=cellcouldbe(rowgroup*3+1:rowgroup*3+3,colgroup*3+1:colgroup*3+3,j);  
        if sum(sum(group2inspect))==1
          [row2change,col2change]=find(group2inspect);
          board(row2change,col2change)=j
          cellcouldbe(row2change,col2change,j)=0;
          keyboard
        endif
      endfor
    endfor
    
        
      
    
    
    [row,col]=find(board==0);
    cellsleft=length(row);
    unsolvbox=[];   
    keyboard 
  endwhile
  

endfunction
