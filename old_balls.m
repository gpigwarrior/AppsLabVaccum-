

clc; clear;

mt = 0.7793; % mass of tube in kg
mb = 0.00275;
rho = 1.2; %
d = 0.04; %
l = 1.525; %

theta = 0.43

v = (mt+mb)/mb*sqrt(2*9.81*(0.2032-0.2032*cos(theta)));

v_n = (mt+mb)*sqrt(2*9.81*(0.2032-0.2032*cos(theta)))/(mb+rho*pi/4*d^2*l);

fprintf('Exit Velocity = %f [m/s]\nExit Velocity with Air Momentum = %f [m/s]\n', v, v_n)
