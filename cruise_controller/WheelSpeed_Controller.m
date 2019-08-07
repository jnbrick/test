clear,clc
close all

%wheel speed dynamics/estimater/controller

C_F=.1;

dt=.1;

t=[0:dt:100];

STM=exp(-C_F*dt);

Q=[.1];


X0=[500];
X(1)=X0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Propagate Truth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=2:length(t)
	X(i)=STM*X(i-1)+randn(1)*sqrt(Q);
end
	
	
figure()
	plot(X)
	
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Propagate Truth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%