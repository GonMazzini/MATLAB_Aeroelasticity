clear all;
close all;
clc;
%% load the txt file
fid = fopen('modeshapes.txt','r');
ignoreFirst = fgetl(fid);
ignoreSecond = fgetl(fid);

% TODO initialize the modes (18,1) << shape
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

%% compute mass matrix
MM = zeros(3);
% start calculating first column of M
MM(1,1) = trapz(r, u1fy .* m .* u1fy) + trapz(r, u1fz .* m .* u1fz) ; 
MM(2,1) = trapz(r, u1ey .* m .* u1fy) + trapz(r, u1ez .* m .* u1fz) ; % unit disp.DOF 2 (u1ey) * unit acc.DOF1(m .* u1fy) + same with z  
MM(3,1) = trapz(r, u2fy .* m .* u1fy) + trapz(r, u2fz .* m .* u1fz) ;

% 2nd column
MM(1,2) = trapz(r, u1fy .* m .* u1ey) + trapz(r, u1fz .* m .* u1ez) ;
MM(2,2) = trapz(r, u1ey .* m .* u1ey) + trapz(r, u1ez .* m .* u1ez) ;
MM(3,2) = trapz(r, u2fy .* m .* u1ey) + trapz(r, u2fz .* m .* u1ez) ;

% 3rd column
MM(1,3) = trapz(r, u1fy .* m .* u2fy) + trapz(r, u1fz .* m .* u2fz) ;
MM(2,3) = trapz(r, u1ey .* m .* u2fy) + trapz(r, u1ez .* m .* u2fz) ;
MM(3,3) = trapz(r, u2fy .* m .* u2fy) + trapz(r, u2fz .* m .* u2fz) ;

% The zero elements are not general, but only due to the choice of mode
% shapes as eigenmodes having an orthogonality constraint.
% The diagonal terms in this mass matrix are sometimes called the
% generalized masses

% Calculate Generalize Force
pn = zeros(1,18);
pt = zeros(1,18);
GF = zeros(3,1);
% convert the modes from Blade Sys to Rotor system
GF(1) = trapz(r, pt .* (u1fz * sin(pitch) + u1fy * cos(pitch))) + ...
    trapz( r, pt .* (u1fz * cos(pitch) - u1fy * sin(pitch)));
GF(2) = trapz(r, pt .* (u1ez * sin(pitch) + u1ey * cos(pitch))) + ...
    trapz( r, pt .* (u1ez * cos(pitch) - u1ey * sin(pitch)));
GF(3) = trapz(r, pt .* (u2fz * sin(pitch) + u2fy * cos(pitch))) + ...
    trapz( r, pt .* (u2fz * cos(pitch) - u2fy * sin(pitch)));

%% Plot some modes 

plot(r,u1fy, r,u1fz,r,u1ey, r,u1ez)

%title('Flapwise for omega1f=3.93 rad/s')

legend('u1fy  ','u1fz','u1ey ','u1ez')
title('for omega1f=3.93 rad/s')
%title('Edgewise for omega1f=6.10 rad/s')

%%

M_nac = 446000; % kg
tower_stiff = 1.7*10^6;
pitch = 0;

M5dof = zeros(5);

% Column 1
M5dof(1,1) = trapz(r, m) + M_nac; % NOTE 3 blades or just for 1? Why?
M5dof(2,1) = 0; % intertia load is perpendicular to rotor, and DOF 2 (theta) is in the rotor plane
u1fz_R = u1fy * sin(pitch) + u1fz * cos(pitch) ; 
u1ez_R = u1ey * sin(pitch) + u1ez * cos(pitch) ;
u2fz_R = u2fy * sin(pitch) + u2fz * cos(pitch) ;
M5dof(3,1) = trapz(r, u1fz_R .* m * 1); % unit disp.DOF 3 (u1fz)  * unit acc.DOF1 (m *1), notice just acc in Z ax.
M5dof(4,1) = trapz(r, u1ez_R .* m * 1);
M5dof(5,1) = trapz(r, u2fz_R .* m * 1);
% Column 2







