%MATLAB code for finding the best fit line using least squares method
x=input('enter a')                      %input in the form of matrix, rows contain points
     a = [linspace(1,1,(length(x)))' x(:,1)]          %forming A of Ax=b
    b= [ x(:,2)]               %forming b of Ax=b
    yy=inv(transpose(a)*a)*transpose(a)*b   %computing projection of matrix A on b, giving x
%plotting the best fit line
  xx=linspace(1,10,50);
  y=yy(1)+yy(2)*xx;
  plot(xx,y)
     %plotting the points(data) for which we found the best fit line
 hold on
    %plot(x(:,1),x(:,2),'rx')
