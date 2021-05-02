function [a12, a34] = TransSys(theta_yaw,theta_tilt,theta_cone)
% Reutrns the transformation matrix: a12 (from sys1 to sys2) , a34 (from
% sys3 to sys 4)
%   Detailed explanation goes here

a1=[1             0               0;...
    0         cos(theta_yaw)    sin(theta_yaw);
    0        -sin(theta_yaw)    cos(theta_yaw)];

a2=[cos(theta_tilt)      0      -sin(theta_tilt);...
       0             1            0             ;...
    sin(theta_tilt)      0       cos(theta_tilt)];

% a3 is just the identity matrix
a3=[1      0      0;...
    0      1      0;...
    0      0      1];

% compute matrix a12
a12=(a1*a2)*a3;

%System 3 to 4
% Theta cone is the angle between the blade and the vertical (i.e tower)
a34=[cos(theta_cone)      0      -sin(theta_cone) ;...
            0             1            0          ;...
     sin(theta_cone)      0       cos(theta_cone)];
 
end

