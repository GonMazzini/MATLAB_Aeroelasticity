function [Wz_up,Wy_up,Wz_qs_up,Wy_qs_up,Wz_int_up,Wy_int_up] = ...
    WakeFilter(dt, r, R, a, vosys4, l, B, phi , rho , F, denom ,Wy, Wz, Wy_qs, Wz_qs, Wy_int, Wz_int)
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

% if nt == 2 && b == 1 && i == 10 
%     disp('stop');
% end

% Compute Wqs Quasi static induced winds
Wz_qs_up = -(B*l*cos(phi)/(4*pi*rho*r*F*denom));
Wy_qs_up = -(B*l*sin(phi)/(4*pi*rho*r*F*denom));    

% Compute time constants
tau1 = 1.1 * R/((1-1.3*min(a,0.5))*norm(vosys4));
tau2 = (0.39-0.26*(r/R)^2)*tau1;  

% Compute Wint using backward difference for the diffeential equations
% of \Óye method. 
Hz = Wz_qs_up+0.6*tau1*(Wz_qs-Wz_qs)/(dt);
Hy = Wy_qs_up+0.6*tau1*(Wz_qs-Wz_qs)/(dt); 

Wz_int_up = Hz + (Wz_int - Hz)*exp(-(dt)/tau1);
Wy_int_up = Hy + (Wy_int - Hy)*exp(-(dt)/tau1);

% 
Wz_up = Wz_int + (Wz-Wz_int)*exp(-(dt)/tau2); 
Wy_up = Wy_int + (Wy-Wy_int)*exp(-(dt)/tau2);

%             Wz(i,b,nt) = real(Wz(i,b,nt));
%             Wy(i,b,nt) = real(Wy(i,b,nt)); 
end

