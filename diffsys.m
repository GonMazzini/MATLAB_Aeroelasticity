function dy = diffsys(t,y)
% Solve system of two equations of 2nd order.
%   y(1) is x(t)
%   y(2) is vx(t)
%   y(3) is theta(t)
%   y(4) is dtheta/dt

% dy=zeros(4,1)

global L m1 m2 sm im g

massmatrix = zeros(2); % 2x2 matrix

massmatrix(1,1) = m2*L + m1;
massmatrix(1,2) = -sm*sin(y(3));
massmatrix(2,1) = massmatrix(1,2);
massmatrix(2,2) = im;

gf(1,1) = y(4)^2*cos(y(3))*sm;
gf(2,1) = g*sm*cos(y(3));

% solve for accelerations
xdotdot = (massmatrix\gf) ; % ' < martin code

dy(1,:) = y(2);
dy(2,:) = xdotdot(1);
dy(3,:) = y(4);
dy(4,:) = xdotdot(2);

end

