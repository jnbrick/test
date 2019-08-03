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
w0=[.1 .2 .2];

t0=0;
tf=100;

% principal axes and MOIs
[princ_axes_tru,princ_moms_tru]=eig(I_tru);
princ_moms_tru=[princ_moms_tru(1,1) princ_moms_tru(2,2) princ_moms_tru(3,3)]';

dyn=@(t,x) attitude_dynamics(x,t,princ_moms_tru,[0 0 0]');
X0=[Q0,w0];

options=odeset('AbsTol',1e-12,'RelTol',1e-12);
[T,X]=ode45(dyn,[t0,tf],X0,options);

W=X(:,5:7)

for i=1:size(X,1)
	H(i,:)=W(i,:).*princ_moms_tru';
	H_mag(i)=norm(H(i,:));
	T(i)=1/2*W(i,:).*princ_moms_tru'*(W(i,:).*princ_moms_tru')';
	end
	
max(H_mag)-min(H_mag)
max(T)-min(T)

figure()
subplot(2,1,1)
hold on
plot(W)
subplot(2,1,2)
hold on
plot(H)
%plot(H_mag)
%subplot(3,1,3)
%plot(T)













