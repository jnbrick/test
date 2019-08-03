function a_x=skew(a)
% generates a skew symmetric matrix from a vector
%	https://en.wikipedia.org/wiki/Skew-symmetric_matrix

a_x=[0 -a(3) a(2);a(3) 0 -a(1);-a(2) a(1) 0];

end