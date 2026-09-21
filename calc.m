% angle=.301
% m_b=.04
% height=8-8*cos(angle)

rho=1.22;
A=pi*0.0399/2;
cd=0.47;
v_0=200;
distance=0.22;
v=v_0;
mass=0.027;
dt=0.000001;
t=[0];
x=[0];
i=2;
while x(i-1)<distance
  fd(i)=-(1/2*rho*(v(i-1))^2*A*cd);
  a(i)=fd(i-1)/mass;
  v(i)=v(i-1)+a(i-1)*dt;
  x(i)=x(i-1)+v(i-1)*dt;
  t(i)=t(i-1)+dt;
  i=i+1;
end
figure(1)
plot(t,x)
figure(2)
plot(x,v)
disp(v(2)-v(i-1))
