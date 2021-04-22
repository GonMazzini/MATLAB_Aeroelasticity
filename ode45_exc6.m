clear all;
close all;

global L m1 m2 sm im g

y = zeros(4);
L = 2; % m
m1 = 1; % kg
m2 = 0.5; % kg/m
sm = 0.5*m2*L^2 ; 
im = (m2*L^3)/3;
g = 9.81; % m/s

ic = [0 0 0 0];
opt = odeset('MaxStep',1e-3);
[t,y] = ode45(@diffsys,[0 16], ic, opt);

%   y(1) is x(t)
%   y(2) is vx(t)
%   y(3) is theta(t)
%   y(4) is dtheta/dt

hold on
plot(t,y(:,2));
plot(t,y(:,3));
plot(t,y(:,4));

xlabel('time (s)')
legend('dx(t)','theta(t)','dtheta(t)')
hold off

save('ode45_result', 'y')


