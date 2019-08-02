clear,clc
close all
a=42164000;

t0=0;
tf=86400*4;
N=10000;

Radial0=10000;

std_rx=100;%m
std_ry=100;%m
std_rz=100;%m

std_vx=10;%m/s
std_vy=10;%m/s
std_vz=10;%m/s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Propagate Truth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mu=3.986e14;

t=linspace(t0,tf,N);

n=sqrt(mu/a^3);

dt=t(2)-t(1);

FullCycle_STM=HCW_STM (n,2*pi/n);

R=[Radial0 0 0]';

V=FullCycle_STM(1:3,4:6)^-1*(R-FullCycle_STM(1:3,1:3)*R);

X=[R;V];

%X=[0 100000 0 0 0 0]';

STM = HCW_STM (n,dt);

X_array=X;
for i=2:N
	X_array(:,i)=STM*X_array(:,i-1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Plot Truth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
hold on
plot3(X_array(1,:),X_array(2,:),X_array(3,:))

plot3(0,0,0,'*')

xlabel('R')
ylabel('I')
zlabel('C')

axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Generate Measurements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

var_rx=std_rx^2;
var_ry=std_ry^2;
var_rz=std_rz^2;

var_vx=std_vx^2;
var_vy=std_vy^2;
var_vz=std_vz^2;

for i=1:N
	E(1,i)=randn*std_rx;
	E(2,i)=randn*std_ry;
	E(3,i)=randn*std_rz;
	E(4,i)=randn*std_vx;
	E(5,i)=randn*std_vy;
	E(6,i)=randn*std_vz;
	Z_array(:,i)=X_array(:,i)+E(:,i);
end

plot3(Z_array(1,:),Z_array(2,:),Z_array(3,:),'*')
axis equal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Run KFilter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Starting Covariance
P0=[
	1	0	0	0	0	0
	0	1	0	0	0	0
	0	0	1	0	0	0
	0	0	0	1	0	0
	0	0	0	0	1	0
	0	0	0	0	0	1
	];
	
X0=[-10000 0 0 0 0 0]';

R0(1,1)=var_rx;
R0(2,2)=var_ry;
R0(3,3)=var_rz;
R0(4,4)=var_vx;
R0(5,5)=var_vy;
R0(6,6)=var_vz;

Q0(1,1)=var_rx;
Q0(2,2)=var_ry;
Q0(3,3)=var_rz;
Q0(4,4)=var_vx;
Q0(5,5)=var_vy;
Q0(6,6)=var_vz;

oldP=P0;
R=R0;
Q=Q0/1000/1000000000;
oldX=X0;
Xest_Array=X0;

for i=2:N+1
	P=((STM*oldP*STM'+Q)^-1+R^-1)^-1;
	K=P*R^-1;
	Xest_Array(:,i)=STM*Xest_Array(:,i-1)+K*(Z_array(:,i-1)-STM*Xest_Array(:,i-1));
	oldP=P;
	
end
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Plot States and Estimates
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	figure()
	hold on

plot(X_array(1,1:end))
plot(Xest_Array(1,2:end),'*')

	figure()
	hold on

plot(X_array(1,1:end)-Xest_Array(1,2:end))

std(X_array(1,N/2:end)-Xest_Array(1,N/2+1:end))







