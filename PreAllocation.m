function [theta, Wy, Wz, Wy_qs, Wz_qs, Wy_int, Wz_int, pn, pt, P1, P2, P3, T1, T2, T3] = PreAllocation(nt_max, B, r)
% Use this function to define the vector sizes.
%   Output: Relative wind speed, loads matrices, power and thrust vectors.

% theta defines the angle between the blade and the vertical axis.
theta = zeros(nt_max, B);

% Relative wind speed.
% Why it starts with -3 ?
Wy = zeros(length(r),B,nt_max);
Wz = zeros(length(r),B,nt_max);

Wy_qs = zeros(length(r),B,nt_max);
Wz_qs = zeros(length(r),B,nt_max);
Wy_int = zeros(length(r),B,nt_max);
Wz_int = zeros(length(r),B,nt_max);

% Define loads matrices size.
pn = zeros(length(r),B,nt_max);
pt = zeros(length(r),B,nt_max);

%Vectors to store the power and thrust
P1 = zeros(1,nt_max);
P2 = zeros(1,nt_max);
P3 = zeros(1,nt_max);
T1 = zeros(1,nt_max);
T2 = zeros(1,nt_max);
T3 = zeros(1,nt_max);

end

