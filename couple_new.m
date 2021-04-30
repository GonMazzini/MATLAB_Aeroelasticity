function [dx] = couple_new(pn, pt, x, dx, pitch, dt)
%UNTITLED6 Summary of this function goes here
%   x and dx are vectors columns with the position and velocity.

%% load the txt file
fid = fopen('modeshapes.txt','r');
ignoreFirst = fgetl(fid);
ignoreSecond = fgetl(fid);

% import the modes
flag = true;
ii = 1;
while flag
    current_line = fgetl(fid);
    ca = regexp( current_line, '\s+', 'split');
    [r(ii,1), u1fy(ii,1), u1fz(ii,1),u1ey(ii,1), u1ez(ii,1) , u2fy(ii,1) ,...
        u2fz(ii,1), m(ii,1)]  = deal(str2double(ca{1}),str2double(ca{2}),str2double(ca{3}),...
        str2double(ca{4}), str2double(ca{5}), str2double(ca{6}), ...
        str2double(ca{7}), str2double(ca{8}) );
    ii = ii + 1;
    if ii == 19
        flag = false;
    end
       
end
%%

[beta, gamma] = deal(0.27,0.51);
tf = 1e-2;

MM = zeros(3);
% start calculating first column of M
MM(1,1) = trapz(r, u1fy .* m .* u1fy) + trapz(r, u1fz .* m .* u1fz) ;
MM(2,1) = trapz(r, u1ey .* m .* u1fy) + trapz(r, u1ez .* m .* u1fz) ;
MM(3,1) = trapz(r, u2fy .* m .* u1fy) + trapz(r, u2fz .* m .* u1fz) ;

% 2nd column
MM(1,2) = trapz(r, u1fy .* m .* u1ey) + trapz(r, u1fz .* m .* u1ez) ;
MM(2,2) = trapz(r, u1ey .* m .* u1ey) + trapz(r, u1ez .* m .* u1ez) ;
MM(3,2) = trapz(r, u2fy .* m .* u1ey) + trapz(r, u2fz .* m .* u1ez) ;

% 3rd column
MM(1,3) = trapz(r, u1fy .* m .* u2fy) + trapz(r, u1fz .* m .* u2fz) ;
MM(2,3) = trapz(r, u1ey .* m .* u2fy) + trapz(r, u1ez .* m .* u2fz) ;
MM(3,3) = trapz(r, u2fy .* m .* u2fy) + trapz(r, u2fz .* m .* u2fz) ;

% Damping matrix
dampmatrix = zeros(3);
dampmatrix = zeros(3);
dampmatrix(1,1) = MM(1,1)*3.93*0.03/pi;  % GM(1,1) * w1f^2  [rad/s]
dampmatrix(2,2) = MM(2,2)*6.10*0.03/pi;
dampmatrix(3,3) = MM(3,3)*11.28*0.03/pi;

% Stiffness amtrix
stiffmatrix = zeros(3);
stiffmatrix(1,1) = MM(1,1)*3.93^2;  % GM(1,1) * w1f^2  [rad/s]
stiffmatrix(2,2) = MM(2,2)*6.10^2;
stiffmatrix(3,3) = MM(3,3)*11.28^2;

GF = zeros(3,1);
% convert the modes from Blade Sys to Rotor system
GF(1) = trapz(r, pt .* (u1fz * sin(pitch) + u1fy * cos(pitch))) + ...
    trapz( r, pt .* (u1fz * cos(pitch) - u1fy * sin(pitch)));
GF(2) = trapz(r, pt .* (u1ez * sin(pitch) + u1ey * cos(pitch))) + ...
    trapz( r, pt .* (u1ez * cos(pitch) - u1ey * sin(pitch)));
GF(3) = trapz(r, pt .* (u2fz * sin(pitch) + u2fy * cos(pitch))) + ...
    trapz( r, pt .* (u2fz * cos(pitch) - u2fy * sin(pitch)));

ddx = MM\(GF - dampmatrix*dx - stiffmatrix*x);
%% 
ddx_up = ddx;
dx_up = dx + dt*ddx;
x_up = x + dt*dx + 0.5*dt^2*ddx;

k = 1;
iter = 0;
    
while k==1
    iter = iter +1;
end 
    
end % function


