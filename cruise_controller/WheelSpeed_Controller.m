clear,clc
close all

%wheel speed dynamics/estimater/controller

C_F=.1;

dt=1;

t=[0:dt:100];

STM=exp(-C_F*dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X0=[500];
X(1)=X0;

Q_truth=[10];%process
R_truth=[30];%measurement

Q=10;
R=30;

H=1;

X0_est=400;
P0=10000;

Xest_Array(1)=X0_est;
P=P0;
P_array(1)=P;

for i=2:length(t)
	X(i)=STM*X(i-1)+randn(1)*sqrt(Q_truth);%truth
	Z(i)=X(i)+randn(1)*sqrt(R_truth); %measurement
	P=((STM*P*STM'+Q)^-1+H'*R^-1*H)^-1; %covariance update (propagation and measurement)
	K=P*H'*R^-1; %Gain Matrix
	Xest_Array(:,i)=STM*Xest_Array(:,i-1)+K*(Z(:,i)-H*(STM*Xest_Array(:,i-1))); %State Estimate
	P_array(i)=P;
end


figure()
hold on
	plot(X)
	plot(Z,'.')
	plot(Xest_Array)
	
figure()
hold on
plot(P_array)






