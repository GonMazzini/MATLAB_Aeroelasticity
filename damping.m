close all;
clear all;

global mass kstiff cdamp ksi fampl fomeg;

kstiff = 2;
mass = 0.5;
ksi = 0.2;
cdamp = ksi * 2 * sqrt(kstiff*mass);
fampl = 3;
omega_nat = sqrt(kstiff/mass);
fomeg = 0.95 * omega_nat;

% [t,y] = ode45(odefun,tspan,y0), where tspan = [t0 tf], integrates the
% system of differential equations y′=f(t,y) from t0 to tf with initial
% conditions y0. Each row in the solution array y corresponds to a value
% returned in column vector t.

tspan = linspace(0,40,2000);
opt = odeset('maxStep', 1e-3);
[t,z] = ode45(@springmass, [0 50], [0 0],opt);
plot(t,z(:,1)*kstiff/fampl);


