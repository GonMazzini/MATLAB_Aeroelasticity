
function dz=newton2(t,z)
global mass kstiff vo chord span alfageom alfatab cltab cdtab ...
    fstab clinvtab clfstab dynstall

dz=zeros(3,1); % a column vector


flowangle = atand(z(2)/vo);
alfaeff = alfageom+flowangle;
clstatic = interp1(alfatab,cltab,alfaeff);
vrel = sqrt(vo^2+z(2)^2);
tau = 4*chord/vrel;
clinv=interp1(alfatab,clinvtab,alfaeff);
clfs=interp1(alfatab,clfstab,alfaeff);
fs=interp1(alfatab,fstab,alfaeff);
if(dynstall==0)
    cl=clstatic;
else
    cl=z(3)*clinv+(1-z(3))*clfs;
end
%cl=clstatic;


lift=0.5*1.225*vrel^2*chord*span*cl;
force=lift*cosd(alfaeff);
dz(1)=z(2);
dz(2)=-(kstiff*z(1)+force)/mass;
dz(3)=(fs-z(3))/tau;
