% apps lab vacuum cannon model 1
clear;
clc;

%the initial pressure  for loop is a last minute addition and a little messy 
final_V=[0]; %m/s
P_initial = [0]; %pa
for k=1:80 
  P_initial(k) = 2000+k*100;

% initial paramaters 
Ball_dia=.04; %m
Mass=.00275;%kg
Pipe_OD=.04826; %m
Pipe_ID=.040386; %m
Tube_Length=1.524; %m


Patm=100000; %pa
starting_temp=27; %C

Ball_pos=Ball_dia/2;
A_ball=pi*(Ball_dia/2)^2;
Burst_pressure=200000; %pa 
dt=.001; %sec

%starting values for arrays and variables 
Pdns=[0];
n=1;
V = [0];
t = [0];
i=1;
  % stop loop when ball exits the tube
  while Ball_pos<Tube_Length
  
    % call functions to calculate pressure
    Pdns(n)=Pdns_Calc(Ball_dia,Pipe_ID,Tube_Length,Ball_pos(n),P_initial(k));
    Pups(n)=Pups_Calc(Patm,n);
  
    % if statment for reseting the downstream pressure when it burts, not the most elegent solution but it works 
    if Pdns(n) >= Burst_pressure
      Pdns(n) = Patm;
      % was used for debugging, keeping it in just in case we need to debug more later 
      if i==1
        % disp("burst")
        % disp(t(n))
        i=0;
      end
  
    end
  % calculate forces and acceleration
    Fups(n)=Pups(n)*A_ball;
    Fdns(n)=Pdns(n)*A_ball;
    accel(n)=(Fups(n)-Fdns(n))/Mass;
  
    % use time step to calculate velocity and position 
    V(n+1) = V(n)+ accel(n)*dt;
    Ball_pos(n+1) = Ball_pos(n)+ V(n)*dt;
    t(n+1) = t(n)+ dt;
    n=n+1;
  
  end
  
  %final velocity
  final_V(k)=V(n);
  
end 

disp("velocity for 2000 pa")
disp(final_V(1))
disp("velocity for 10000 pa")
disp(final_V(k))

  %figures
  figure(1)
  plot(t,V);
  title("Plot of ball velocity vs time ")
  xlabel("time (s)")
  ylabel("Velocity (m/s)")
  figure(2)
  plot(t,Ball_pos);
  title("Plot of ball position vs time ")
  xlabel("time (s)")
  ylabel("postion (m)")

figure(3)
  plot(P_initial,final_V);
  title("Final velocity depending on initial downstream pressure")
  xlabel("initial pressure (pa)")
  ylabel("Final velocity (m/s)")



  
  %calculate downstream pressure 
function P_current = Pdns_Calc(Ball_dia,Pipe_ID,Tube_Length,Ball_pos,P_initial)
  % makes only a small change hemisphere takes into account the volume of the ball for the total volume 
hemisphere=2/3*pi*(Ball_dia/2)^3;
vol_initial=pi*(Pipe_ID/2)^2*(Tube_Length-(Ball_dia/2))-hemisphere;
vol_current=abs(pi*(Pipe_ID/2)^2*(Tube_Length-Ball_pos)-hemisphere);
% use thermo equation for calculating pressure, k is ratio for specific heats at about room temp 
k=1.4;
P_current=P_initial*(vol_initial/vol_current)^k;
end


function pups = Pups_Calc(Patm,n)
pups = Patm;
end



