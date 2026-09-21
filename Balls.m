
clc; clear;

mt = 0.7793; % mass of tube in kg
mb = 0.00275;
rho = 1.2; %
d = 0.04; %
l = 1.525; %
r_l=0.2032;
g=9.81;

% Open CSV and read third column into array, then find its maximum
filename = 'raw_data/run3.csv';
Table = readtable(filename);
angles = Table{:,3};
pressures = Table{:,2};

maxAngle = max(angles);
minPressure = min(pressures);


theta = maxAngle
% theta = input("Input radians: ");
height=(r_l-r_l*cos(theta))
v = (mt+mb)/mb*sqrt(2*g*(r_l-r_l*cos(theta)));

v_n = (mt+mb)*sqrt(2*g*(r_l-r_l*cos(theta)))/(mb+rho*pi/4*d^2*l);
disp("-----------------")
disp(minPressure)
disp(v)
disp(maxAngle)
fprintf('Exit Velocity = %f [m/s]\nExit Velocity with Air Momentum = %f [m/s]\n', v, v_n)

