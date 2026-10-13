clear
clc
syms qm cd beta epsilon rho delta_p d pi D p1 p2 k mass_flow velocity
beta=d/D
delta_p=p1-p2
mass_flow=rho*pi*D^2*velocity;
% epsilon=1-(0.351+0.256*beta^4+0.93*beta^8)*(1-(p2/p1)^(1/k))
eqn = mass_flow==cd/(sqrt(1-(d/D)^4))*epsilon*pi/4*d^2*sqrt(2*rho*delta_p)
solution = solve(eqn,d);
solution2 = solve(eqn,velocity)
disp("--------------------")
disp(solution)

clear
clc
rho=1.23;
velocity= 160;
D=0.04;
mass_flow=rho*pi*D^2*velocity;
cd=0.7;
epsilon=1;
pi=3.1415;
k=1.4;
p1=100000;
p2=62342.6439;
delta_p=p1-p2;
% beta=((- delta_p*rho*pi^2*cd^2*d^4*epsilon^2 + 8*qm^2)/(8*qm^2))^(1/4);
% diamater= -20*5^(1/2)*D*((2^(1/2)*qm)/(8000000*qm^2 + 421201*D^4*cd^2*p1*pi^2*rho - 421201*D^4*cd^2*p2*pi^2*rho - 332288*D^4*beta^4*cd^2*p1*pi^2*rho + 332288*D^4*beta^4*cd^2*p2*pi^2*rho - 1141604*D^4*beta^8*cd^2*p1*pi^2*rho + 1141604*D^4*beta^8*cd^2*p2*pi^2*rho + 476160*D^4*beta^12*cd^2*p1*pi^2*rho - 476160*D^4*beta^12*cd^2*p2*pi^2*rho + 864900*D^4*beta^16*cd^2*p1*pi^2*rho - 864900*D^4*beta^16*cd^2*p2*pi^2*rho + 455598*D^4*cd^2*p1*pi^2*rho*(p2/p1)^(1/k) - 455598*D^4*cd^2*p2*pi^2*rho*(p2/p1)^(1/k) + 123201*D^4*cd^2*p1*pi^2*rho*(p2/p1)^(2/k) - 123201*D^4*cd^2*p2*pi^2*rho*(p2/p1)^(2/k) + 152576*D^4*beta^4*cd^2*p1*pi^2*rho*(p2/p1)^(1/k) - 152576*D^4*beta^4*cd^2*p2*pi^2*rho*(p2/p1)^(1/k) + 423208*D^4*beta^8*cd^2*p1*pi^2*rho*(p2/p1)^(1/k) - 423208*D^4*beta^8*cd^2*p2*pi^2*rho*(p2/p1)^(1/k) - 952320*D^4*beta^12*cd^2*p1*pi^2*rho*(p2/p1)^(1/k) + 952320*D^4*beta^12*cd^2*p2*pi^2*rho*(p2/p1)^(1/k) - 1729800*D^4*beta^16*cd^2*p1*pi^2*rho*(p2/p1)^(1/k) + 1729800*D^4*beta^16*cd^2*p2*pi^2*rho*(p2/p1)^(1/k) + 179712*D^4*beta^4*cd^2*p1*pi^2*rho*(p2/p1)^(2/k) - 179712*D^4*beta^4*cd^2*p2*pi^2*rho*(p2/p1)^(2/k) + 718396*D^4*beta^8*cd^2*p1*pi^2*rho*(p2/p1)^(2/k) - 718396*D^4*beta^8*cd^2*p2*pi^2*rho*(p2/p1)^(2/k) + 476160*D^4*beta^12*cd^2*p1*pi^2*rho*(p2/p1)^(2/k) - 476160*D^4*beta^12*cd^2*p2*pi^2*rho*(p2/p1)^(2/k) + 864900*D^4*beta^16*cd^2*p1*pi^2*rho*(p2/p1)^(2/k) - 864900*D^4*beta^16*cd^2*p2*pi^2*rho*(p2/p1)^(2/k))^(1/2))^(1/2)

% diamater= root(- 8000000*D^16*qm^2 + 8000000*D^12*qm^2*z^2 + 864900*cd^2*p1*pi^2*rho*z^10 - 864900*cd^2*p2*pi^2*rho*z^10 + 476160*D^4*cd^2*p1*pi^2*rho*z^8 - 476160*D^4*cd^2*p2*pi^2*rho*z^8 - 1141604*D^8*cd^2*p1*pi^2*rho*z^6 + 1141604*D^8*cd^2*p2*pi^2*rho*z^6 - 332288*D^12*cd^2*p1*pi^2*rho*z^4 + 332288*D^12*cd^2*p2*pi^2*rho*z^4 + 421201*D^16*cd^2*p1*pi^2*rho*z^2 - 421201*D^16*cd^2*p2*pi^2*rho*z^2 - 1729800*cd^2*p1*pi^2*rho*z^10*(p2/p1)^(1/k) + 1729800*cd^2*p2*pi^2*rho*z^10*(p2/p1)^(1/k) + 864900*cd^2*p1*pi^2*rho*z^10*(p2/p1)^(2/k) - 864900*cd^2*p2*pi^2*rho*z^10*(p2/p1)^(2/k) - 952320*D^4*cd^2*p1*pi^2*rho*z^8*(p2/p1)^(1/k) + 952320*D^4*cd^2*p2*pi^2*rho*z^8*(p2/p1)^(1/k) + 423208*D^8*cd^2*p1*pi^2*rho*z^6*(p2/p1)^(1/k) - 423208*D^8*cd^2*p2*pi^2*rho*z^6*(p2/p1)^(1/k) + 152576*D^12*cd^2*p1*pi^2*rho*z^4*(p2/p1)^(1/k) - 152576*D^12*cd^2*p2*pi^2*rho*z^4*(p2/p1)^(1/k) + 455598*D^16*cd^2*p1*pi^2*rho*z^2*(p2/p1)^(1/k) - 455598*D^16*cd^2*p2*pi^2*rho*z^2*(p2/p1)^(1/k) + 476160*D^4*cd^2*p1*pi^2*rho*z^8*(p2/p1)^(2/k) - 476160*D^4*cd^2*p2*pi^2*rho*z^8*(p2/p1)^(2/k) + 718396*D^8*cd^2*p1*pi^2*rho*z^6*(p2/p1)^(2/k) - 718396*D^8*cd^2*p2*pi^2*rho*z^6*(p2/p1)^(2/k) + 179712*D^12*cd^2*p1*pi^2*rho*z^4*(p2/p1)^(2/k) - 179712*D^12*cd^2*p2*pi^2*rho*z^4*(p2/p1)^(2/k) + 123201*D^16*cd^2*p1*pi^2*rho*z^2*(p2/p1)^(2/k) - 123201*D^16*cd^2*p2*pi^2*rho*z^2*(p2/p1)^(2/k), z, 1)^(1/2)
diamater = 2^(1/2)*D*((2^(1/2)*mass_flow)/(8*mass_flow^2 + D^4*cd^2*epsilon^2*p1*pi^2*rho - D^4*cd^2*epsilon^2*p2*pi^2*rho)^(1/2))^(1/2)

solution2=solve(eqn,mass_flow)
