function dz = springmass(t,z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global mass kstiff cdamp ksi fampl fomeg;

force = fampl*cos(fomeg*t);

dz(1,1) = z(2);
dz(2,1) = (-kstiff*z(1)-cdamp*z(2))/mass + force/mass;

end

