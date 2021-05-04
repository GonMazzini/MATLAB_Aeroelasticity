function [M5dof,K5_dof, GF5] = Mat_5dof(l_pitch, cone, r, pn, pt, Mgen,nt)
% Return Mass, Stiffnes and Damping matrices and Generalized Force
% for a 5 DOF.
%   Inputs:
%       pn (normal loads)
%       pt (tangential loads)
%       pitch (pitch angle [rad]
%       cone (cone angle)
%       r (radial positions)
%       Mgen (generator torque)
% --------------------

load('modes_shapes.mat') % load the modes shapes and m (mass)
M_nac = 446000; % kg
k_tow = 1.7*10^6;  % tower_stiff
omega1f = 3.93  ; % rad/s
omega1e = 6.10  ; %rad/s 
omega2f = 11.28;
M5dof = zeros(5);
% --------------------
% Column one
M5dof(1,1) = 3*trapz(r, m) + M_nac; % NOTE 3 blades or just for 1? Why?
M5dof(2,1) = 0; % intertia load is perpendicular to rotor, and DOF 2 (theta) is in the rotor plane
% Projection of the modes in the Rotor plane, in order to calculate the  work corresp. to unit acc. in Z direction
u1fz_R = - u1fy * sin(l_pitch) + u1fz * cos(l_pitch) ; 
u1ez_R = - u1ey * sin(l_pitch) + u1ez * cos(l_pitch) ;
u2fz_R = - u2fy * sin(l_pitch) + u2fz * cos(l_pitch) ;
M5dof(3,1) = trapz(r, u1fz_R .* m * 1); % unit disp.DOF 3 (u1fz)  * unit acc.DOF1 (m *1), notice just acc in Z ax.
M5dof(4,1) = trapz(r, u1ez_R .* m * 1);
M5dof(5,1) = trapz(r, u2fz_R .* m * 1);
% Column 2
% the inertia force is given by p = (0, m*r*cos(cone),0)m
M5dof(1,2) = 0; % acc. (Y dir) is perp. to displacment in DOF 1 (in Z)
M5dof(2,2) = 3*trapz(r, m .* r.^2 .* cos(cone).^2); % The whole system must be consider for a displacement in DOF 2 (theta)
M5dof(3,2) = trapz(r, m .* r * cos(cone) .* u1fy); % p * disp. DOF 3 (u1fy, u1fz)
M5dof(4,2) = trapz(r, m .* r * cos(cone) .* u1ey);
M5dof(5,2) = trapz(r, m .* r * cos(cone) .* u2fy);
% Column 3
M5dof(1,3) = M5dof(3,1);
M5dof(2,3) = M5dof(3,2);
M5dof(3,3) = trapz(r, m .* u1fy .* u1fy + m .* u1fz .* u1fz);
M5dof(4,3) = 0;
M5dof(5,3) = 0;
% Column 4
M5dof(1,4) =  M5dof(4,1);
M5dof(2,4) = M5dof(4,2);
M5dof(3,4) = 0;
M5dof(4,4) = trapz(r, m .* u1ey .* u1ey + m .* u1ez .* u1ez);
M5dof(5,4) = 0;
% Column 5
M5dof(1,5) =  M5dof(5,1);
M5dof(2,5) = M5dof(5,2);
M5dof(3,5) = 0;
M5dof(4,5) = 0;
M5dof(5,5) = trapz(r, m .* u2fy .* u2fy + m .* u2fz .* u2fz);

%% STIFFNESS -----------------------------
% NOTE Where should we use the eigenfrecuencies of inv(K)*M . GX = (1/w^2) . GX
K5_dof = zeros(5);
K5_dof(1,1) = k_tow;
K5_dof(3,3) = omega1f^2 * M5dof(3,3);
K5_dof(4,4) = omega1e^2 * M5dof(4,4);
K5_dof(5,5) = omega2f^2 * M5dof(5,5);
%% GF -----------------------------
GF5 = zeros(5,1);
TorqueAero = trapz(r,r.*pt(:,1,nt)) + trapz(r,r.*pt(:,2,nt)) + trapz(r,r.*pt(:,3,nt)); % Sum the torque for each blade
Thrust = trapz(r,pn(:,1,nt)) + trapz(r,pn(:,2,nt)) + trapz(r,pn(:,3,nt)); % Sum the thrust for each blade

GF5(1) = Thrust; 
GF5(2) =  TorqueAero - Mgen;
GF5(3) = trapz(r, pt(:,1,nt) .* (u1fz * sin(l_pitch) + u1fy * cos(l_pitch))) + ...
                    trapz( r, pn(:,1,nt) .* (u1fz * cos(l_pitch) - u1fy * sin(l_pitch)));
GF5(4) = trapz(r, pt(:,1,nt) .* (u1ez * sin(l_pitch) + u1ey * cos(l_pitch))) + ...
                    trapz( r, pn(:,1,nt) .* (u1ez * cos(l_pitch) - u1ey * sin(l_pitch)));
GF5(5) = trapz(r, pt(:,1,nt) .* (u2fz * sin(l_pitch) + u2fy * cos(l_pitch))) + ...
                    trapz( r, pn(:,1,nt) .* (u2fz * cos(l_pitch) - u2fy * sin(l_pitch)));

end

