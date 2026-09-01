% apps lab vacuum cannon model 1
clear;
clc;

%the initial pressure  for loop is a last minute addition and a little messy


% initial paramaters
Ball_dia=[.04,0.0399,0.0401]; %m
Mass=[0.00275,.00270,0.0028];%kg
Pipe_OD=.04826; %m
Pipe_ID=[.040386,0.039878,.04826]; %m
Tube_Length=[1.524,1.4986,1.5494]; %m
P_initial=[6000,2000,10000];
air_density=1.2; %kg/m^3

P_atm=100000; %pa
starting_temp=300; %K

Burst_pressure=[250000,200000,300000]; %pa
dt=.001; %sec


for k = [2,3]
  V_Delta(k,1)=simulation(Ball_dia(k), Mass(1), Pipe_ID(1), Tube_Length(1), Burst_pressure(1), P_initial(1), air_density, P_atm, starting_temp, Pipe_OD,dt );
end
delta(1)=V_Delta(3,1)-V_Delta(2,1);
for k = [2,3]
  V_Delta(k,2)=simulation(Ball_dia(1), Mass(k), Pipe_ID(1), Tube_Length(1), Burst_pressure(1), P_initial(1), air_density, P_atm, starting_temp, Pipe_OD,dt );
end
delta(2)=V_Delta(3,2)-V_Delta(2,2);
for k = [2,3]
  V_Delta(k,3)=simulation(Ball_dia(1), Mass(1), Pipe_ID(k), Tube_Length(1), Burst_pressure(1), P_initial(1), air_density, P_atm, starting_temp, Pipe_OD,dt );
end
delta(3)=V_Delta(3,3)-V_Delta(2,3);
for k = [2,3]
  V_Delta(k,4)=simulation(Ball_dia(1), Mass(1), Pipe_ID(1), Tube_Length(k), Burst_pressure(1), P_initial(1), air_density, P_atm, starting_temp, Pipe_OD,dt );
end
delta(4)=V_Delta(3,4)-V_Delta(2,4);
for k = [2,3]
  V_Delta(k,5)=simulation(Ball_dia(1), Mass(1), Pipe_ID(1), Tube_Length(1), Burst_pressure(k), P_initial(1), air_density, P_atm, starting_temp, Pipe_OD,dt );
end
delta(5)=V_Delta(3,5)-V_Delta(2,5);
for k = [2,3]
  V_Delta(k,6)=simulation(Ball_dia(1), Mass(1), Pipe_ID(1), Tube_Length(1), Burst_pressure(1), P_initial(k), air_density, P_atm, starting_temp, Pipe_OD,dt );
end
delta(6)=V_Delta(3,6)-V_Delta(2,6);

delta_final=sqrt(delta(1)^2 + delta(2)^2 + delta(3)^2 +delta(4)^2 +delta(5)^2 +delta(6)^2 )





function final_V = simulation(Ball_dia, Mass, Pipe_ID, Tube_Length, Burst_pressure, P_initial, air_density, P_atm, starting_temp, Pipe_OD,dt)
%starting values for arrays and variables
P_dns=[0];
P_ups=[P_atm]
n=1;
V = [0];
t = [0];
final_V=[0]; %m/s

Ball_pos=Ball_dia/2;
A_ball=pi*(Ball_dia/2)^2;
% stop loop when ball exits the tube
while Ball_pos<Tube_Length

  % call functions to calculate pressure
  P_dns(n)=Pdns_Calc(Ball_dia,Pipe_ID,Tube_Length,Ball_pos(n),P_initial,Burst_pressure,P_atm);
  P_ups(n+1)=Pups_Calc(P_atm,V(n),Ball_pos(n),Pipe_ID,starting_temp,P_ups(n));

  % calculate forces and acceleration
  Fups(n)=P_ups(n)*A_ball;
  Fdns(n)=P_dns(n)*A_ball;
  accel(n)=(Fups(n)-Fdns(n))/Mass;

  % use time step to calculate velocity and position
  V(n+1) = V(n)+ accel(n)*dt;
  Ball_pos(n+1) = Ball_pos(n)+ V(n)*dt;
  t(n+1) = t(n)+ dt;
  n=n+1;

end
final_V=V(n)
%final velocity


disp("velocity for 2000 pa")
disp(final_V(1))
disp("velocity for 10000 pa")
disp(final_V)

%figures
% figure(1)
% plot(t,V);
% title("Plot of ball velocity vs time ")
% xlabel("time (s)")
% ylabel("Velocity (m/s)")
% figure(2)
% plot(t,Ball_pos);
% title("Plot of ball position vs time ")
% xlabel("time (s)")
% ylabel("postion (m)")
%
% figure(3)
% plot(P_initial,final_V);
% title("Final velocity depending on initial downstream pressure")
% xlabel("initial pressure (pa)")
% ylabel("Final velocity (m/s)")
% disp("")

end

%calculate downstream pressure
function P_current = Pdns_Calc(Ball_dia,Pipe_ID,Tube_Length,Ball_pos,P_initial,Burst_pressure,Patm)
% if statment for reseting the downstream pressure when it burts, not the most elegent solution but it works
k=1.4;
hemisphere=2/3*pi*(Ball_dia/2)^3;
vol_initial=pi*(Pipe_ID/2)^2*(Tube_Length-(Ball_dia/2))-hemisphere;
vol_current=abs(pi*(Pipe_ID/2)^2*(Tube_Length-Ball_pos)-hemisphere);
% use adiabatic equation for calculating pressure, k is ratio for specific heats at about room tem
P_current=P_initial*(vol_initial/vol_current)^k;
if P_current>Burst_pressure

  P_current = Patm;
end
end


function pups = Pups_Calc(Patm,Velocity,length,pipe_ID,starting_temp,P_ups)
Gas_constant=287.058;
air_density=P_ups/(Gas_constant*starting_temp);
friction_factor=0.02;
loss_coeff=0.74;
loss_bernoulli=air_density*Velocity^2/2;
loss_viscous=friction_factor*(air_density*Velocity^2*length/2*pipe_ID);
loss_entrence=loss_coeff*(air_density*Velocity^2/2);
pups=Patm-loss_bernoulli-loss_viscous-loss_entrence;
end



