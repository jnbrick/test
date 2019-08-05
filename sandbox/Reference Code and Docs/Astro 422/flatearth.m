function flatearth
%=====================================:
%
% example of how to use RK4
%
%=====================================:

%----- open outfprintf file

  outfile=fopen('flatearth.out','wt');

%----- title

  fprintf(outfile,'          project flat earth');
  fprintf(outfile,'\n\n\n');   %% 3 carriage returns

%----- how to set dtype

  dtype = 'nnnnnnnnn2'; %turn off all perturbations
  dtype(1) = 'y';     %turn on perturbation #1 

%----- fill up the state vector

  r(1) = 7000.0;  %% initial r vector components
  r(2) = 1.0;
  r(3) = 2.0;
  v(1) = 1.0;  %% initial v vector components
  v(2) = 1.0;
  v(3) = 5.0;

  x = [r(1);r(2);r(3);v(1);v(2);v(3)];  %% stack into state vector

  JDstart = 2455197.5;             %% 1 Jan 2010 00:00  
  JDstop  = JDstart + 1.001/86400; %% stop 1.001 seconds later
  
  deltsec = .01;         %% take .01 sec steps
  
  nsteps = floor((JDstop - JDstart)*86400/deltsec); %% calculate # of steps
  bc = 0.0;              %% ballistic coefficient = 0

%----- integrate the equations of motion

  JD = JDstart;
  for i = 1:nsteps,
    x = rk4(JD,deltsec,dtype,bc,x);    %% integrate the state
    JD = JDstart + i*deltsec/86400.0;  %% update JD
  end;

%---- a last smaller fractional part of a step may need to be taken 

  deltsec = (JDstop - JD)*86400;
  x = rk4(JD,deltsec,dtype,bc,x);    %% integrate the state
  
%----- extract the r and v vector from the state vector (1 sec later)

  r = [x(1); x(2); x(3)];  %% position components
  v = [x(4); x(5); x(6)];  %% velocity components

%----- print out results
  fprintf(outfile,'r ='); fprintf(outfile,'%11.5f %11.5f %11.5f \n',r);
  fprintf(outfile,'v ='); fprintf(outfile,'%11.5f %11.5f %11.5f \n',v);


  fclose(outfile);

  disp ('flatearth done');
  
end
