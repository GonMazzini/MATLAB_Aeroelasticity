function [Wz,Wy] = WakeFilter(nt, b, i, dt, r, R, a, vosys4, l, B, phi , rho , F, denom ,Wy, Wz, Wy_qs, Wz_qs, Wy_int, Wz_int)
% Compute the relative Wind (Wz and Wy) considering the dynamic wake model.
% using the \Öye method
%   % Explanation: In order to take into account the time delay before the
%     equations for Induced Wind (9.13 and 9.14) are valid, a dynamic wake 
%     model must be applied.
%       
%   - Wqs is the quasi static value found by Equations 9.13 and 9.14,
%   - Wint an intermediate value
%   - Wz/Wy the final filtered value to be used as the induced velocity.
%   

% Compute Wqs Quasi static induced winds
Wz_qs(i,b,nt) = -(B*l*cos(phi)/(4*pi*rho*r(i)*F*denom));
Wy_qs(i,b,nt) = -(B*l*sin(phi)/(4*pi*rho*r(i)*F*denom));    

% Compute time constants
tau1 = 1.1 * R/((1-1.3*min(a,0.5))*norm(vosys4));
tau2 = (0.39-0.26*(r(i)/R)^2)*tau1;  

% Compute Wint using backward difference for the diffeential equations
% of \Óye method. 
Hz = Wz_qs(i,b,nt)+0.6*tau1*(Wz_qs(i,b,nt)-Wz_qs(i,b,nt-1))/(dt);
Hy = Wy_qs(i,b,nt)+0.6*tau1*(Wz_qs(i,b,nt)-Wz_qs(i,b,nt-1))/(dt); 

Wz_int(i,b,nt) = Hz + (Wz_int(i,b,nt-1) - Hz)*exp(-(dt)/tau1);
Wy_int(i,b,nt) = Hy + (Wy_int(i,b,nt-1) - Hy)*exp(-(dt)/tau1);

% 
Wz(i,b,nt) = Wz_int(i,b,nt) + (Wz(i,b,nt-1)-Wz_int(i,b,nt))*exp(-(dt)/tau2); 
Wy(i,b,nt) = Wy_int(i,b,nt) + (Wy(i,b,nt-1)-Wy_int(i,b,nt))*exp(-(dt)/tau2);

%             Wz(i,b,nt) = real(Wz(i,b,nt));
%             Wy(i,b,nt) = real(Wy(i,b,nt)); 
end

