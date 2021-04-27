function [u, dt, nt_max, time, x, y, z] = MannFunc(H, vo_hub, time_reduction)
% Returns the velocity vector (u) for the MannBox (add further explanation)
%   Detailed explanation missing

fid=fopen('sim1.bin');
L1 = 6142.5; L2 = 180; L3 = 180; n1=4096; n2=32; n3=32;
uraw=fread(fid,'single');
itael=0;
u = zeros(n1,n2,n3);

for i=1:n1
    for j=1:n2
        for k=1:n3
            itael=itael+1;
            u(i,j,k)=uraw(itael);
        end
    end
end

deltay = L2/(n2-1); deltax = L1/(n1-1); deltaz = L3/(n3-1);
y=zeros(n2,1); x=zeros(n3,1); z=zeros(n1,1);

for j=1:n2
    y(j)=(j-1)*deltay - L2/2;
end

for k=1:n3
    x(k)=(k-1)*deltaz + H - 0.5*L3;
end

for i=1:n1
    z(i)=(i-1)*deltax;
end

dt = L1/((n1-1)*vo_hub); % Time step definition
nt_max = floor(n1/time_reduction); % Grid lenght in z direction
time = zeros(nt_max,1); % Time step vector

end

