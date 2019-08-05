function xdot=attitude_dynamics(x,t,I,T)
	%attitude dynamics about principal axes
	%keyboard
	%state vector is 7 long
	%x=reshape(x,[7,1]);
	
	q_ijk=[x(1);x(2);x(3)];
	q_0=x(4);
	w=[x(5);x(6);x(7)];
	
	%	3 vec components of quaternion (x,y,z)
	xdot(1:3)=1/2*(skew(q_ijk)+q_0*eye(3))*w;
	%	1 scalar component of quaternion
	xdot(4)=-1/2*q_ijk'*w;
	%	3 vec components of body rate
	xdot(5)=(I(2,2)-I(3,3))/I(1,1)*w(2)*w(3)+T(1)/I(1,1);
	xdot(6)=(I(3,3)-I(1,1))/I(2,2)*w(3)*w(1)+T(2)/I(2,2);
	xdot(7)=(I(1,1)-I(2,2))/I(3,3)*w(1)*w(2)+T(3)/I(3,3);
	xdot=xdot';

end