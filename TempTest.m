%% Plot total edgewise bending moment
py_tot = zeros(18,nt_max);
M_total_Edge = zeros(1,nt_max);
M_inertia_Edge = zeros(1,nt_max);
for nt = 1:nt_max % Calculate the bending moment for BLADE 1
    py_tot(:,nt) = pt(:,1,nt) - m(:).*u_dot_dot_blade_y(:,nt);
    M_total_Edge(nt) = trapz(r, r.* py_tot(:,nt)) ;
    M_inertia_Edge(nt) = trapz(r,r.* - m(:).*u_dot_dot_blade_y(:,nt)) ; 
end
figure(1)
plot(time, M_total_Edge, time, Medge_1, time, M_inertia_Edge)

title('Edgewise bending moment')
legend('M_{Edge total}','M_{aero loads}', 'M_{inertia edge}')
xlim([0 20])

%% Plot total flapwise bending moment

pz_tot = zeros(18,nt_max);
M_total_Flap = zeros(1,nt_max);
M_inertia_Flap = zeros(1,nt_max);
for nt = 1:nt_max % Calculate the bending moment for BLADE 1
    pz_tot(:,nt) =  pn(:,1,nt) - m(:).*u_dot_dot_blade_z(:,nt);
    M_total_Flap(nt) = trapz(r, r.* pz_tot(:,nt)) ;
    M_inertia_Flap(nt) = trapz(r,r.* - m(:).*u_dot_dot_blade_z(:,nt)) ; 
end
figure(2)
plot(time, M_total_Flap, time, Mflap_1, time, M_inertia_Flap)

title('Flapw bending moment')
legend('M_{Flap total}','M_{aero loads}', 'M_{inertia flap}')
xlim([0 20])







