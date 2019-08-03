clear,clc
close all

% Vehicle properties
Ixx=100;
Iyy=100;
Izz=200;

Ixy=-20;
Iyz=30;
Ixz=0;

I_est=[	Ixx Ixy Ixz
		Ixy Iyy Iyz
		Ixz Iyz Izz	];
		
I_tru=I_est;

% Scenario Definition
Q0=[0 0 0 1];
w0=[0 0 0];

t0=0;
tf=100;



% 
[princ_axes_tru,princ_moms_tru]=eig(I_tru);

