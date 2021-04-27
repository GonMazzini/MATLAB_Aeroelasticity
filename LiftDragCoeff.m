function [Cl,Cd] = LiftDragCoeff(dt, nt_max, c, r,  t_c, Vrel , i, b, nt, alpha , dyn_stall, FFA_W3_241_ds, FFA_W3_301_ds, FFA_W3_360_ds, FFA_W3_480_ds, FFA_W3_600_ds,cylinder_ds)
% UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

t_c_vector = [24.1 30.1 36 48 60 100];
% the lift coefficient is affected by the dynamic stall if dyn_stall == 1
if dyn_stall == 0   
    
    %Lift coefficients for each type of airfoil
    Cl_t_c(1) = interp1(FFA_W3_241_ds(:,1),FFA_W3_241_ds(:,2),alpha*180/pi);
    Cl_t_c(2) = interp1(FFA_W3_301_ds(:,1),FFA_W3_301_ds(:,2),alpha*180/pi);
    Cl_t_c(3) = interp1(FFA_W3_360_ds(:,1),FFA_W3_360_ds(:,2),alpha*180/pi);
    Cl_t_c(4) = interp1(FFA_W3_480_ds(:,1),FFA_W3_480_ds(:,2),alpha*180/pi);
    Cl_t_c(5) = interp1(FFA_W3_600_ds(:,1),FFA_W3_600_ds(:,2),alpha*180/pi);
    Cl_t_c(6) = interp1(cylinder_ds(:,1),cylinder_ds(:,2),alpha*180/pi);

    %Find the lift coefficient for the actual airfoil
    Cl = interp1(t_c_vector,Cl_t_c,t_c);
    
else 
    
    fs_dyn = ones(length(r),3,nt_max); % preallocate Dynamic separation function
    
    %Lift inviscid coefficients for each type of airfoil
    Cl_t_c_inv(1) = interp1(FFA_W3_241_ds(:,1),FFA_W3_241_ds(:,end-1),alpha*180/pi);
    Cl_t_c_inv(2) = interp1(FFA_W3_301_ds(:,1),FFA_W3_301_ds(:,end-1),alpha*180/pi);
    Cl_t_c_inv(3) = interp1(FFA_W3_360_ds(:,1),FFA_W3_360_ds(:,end-1),alpha*180/pi);
    Cl_t_c_inv(4) = interp1(FFA_W3_480_ds(:,1),FFA_W3_480_ds(:,end-1),alpha*180/pi);
    Cl_t_c_inv(5) = interp1(FFA_W3_600_ds(:,1),FFA_W3_600_ds(:,end-1),alpha*180/pi);
    Cl_t_c_inv(6) = interp1(cylinder_ds(:,1),cylinder_ds(:,end-1),alpha*180/pi);

    %Lift fully separated coefficients for each type of airfoil
    Cl_t_c_fs(1) = interp1(FFA_W3_241_ds(:,1),FFA_W3_241_ds(:,end),alpha*180/pi);
    Cl_t_c_fs(2) = interp1(FFA_W3_301_ds(:,1),FFA_W3_301_ds(:,end),alpha*180/pi);
    Cl_t_c_fs(3) = interp1(FFA_W3_360_ds(:,1),FFA_W3_360_ds(:,end),alpha*180/pi);
    Cl_t_c_fs(4) = interp1(FFA_W3_480_ds(:,1),FFA_W3_480_ds(:,end),alpha*180/pi);
    Cl_t_c_fs(5) = interp1(FFA_W3_600_ds(:,1),FFA_W3_600_ds(:,end),alpha*180/pi);
    Cl_t_c_fs(6) = interp1(cylinder_ds(:,1),cylinder_ds(:,end),alpha*180/pi);

    %Static separation function for each type of airfoil
    fs_st_t_c(1) = interp1(FFA_W3_241_ds(:,1),FFA_W3_241_ds(:,end-2),alpha*180/pi);
    fs_st_c(2) = interp1(FFA_W3_301_ds(:,1),FFA_W3_301_ds(:,end-2),alpha*180/pi);
    fs_st_t_c(3) = interp1(FFA_W3_360_ds(:,1),FFA_W3_360_ds(:,end-2),alpha*180/pi);
    fs_st_t_c(4) = interp1(FFA_W3_480_ds(:,1),FFA_W3_480_ds(:,end-2),alpha*180/pi);
    fs_st_t_c(5) = interp1(FFA_W3_600_ds(:,1),FFA_W3_600_ds(:,end-2),alpha*180/pi);
    fs_st_t_c(6) = interp1(cylinder_ds(:,1),cylinder_ds(:,end-2),alpha*180/pi);     

    Cl_inv = interp1(t_c_vector,Cl_t_c_inv,t_c);
    Cl_fs = interp1(t_c_vector,Cl_t_c_fs,t_c);
    fs_st = interp1(t_c_vector,fs_st_t_c,t_c);
    
    tau_sep = 4*c/Vrel;
    fs_dyn(i,b,nt) = fs_st + (fs_dyn(i,b,nt-1)- fs_st)*exp(-dt/tau_sep);
    Cl = fs_dyn(i,b,nt)*Cl_inv + (1-fs_dyn(i,b,nt))*Cl_fs;            
end

%Drag coefficients for each type of airfoil
Cd_t_c(1) = interp1(FFA_W3_241_ds(:,1),FFA_W3_241_ds(:,3),alpha*180/pi);
Cd_t_c(2) = interp1(FFA_W3_301_ds(:,1),FFA_W3_301_ds(:,3),alpha*180/pi);
Cd_t_c(3) = interp1(FFA_W3_360_ds(:,1),FFA_W3_360_ds(:,3),alpha*180/pi);
Cd_t_c(4) = interp1(FFA_W3_480_ds(:,1),FFA_W3_480_ds(:,3),alpha*180/pi);
Cd_t_c(5) = interp1(FFA_W3_600_ds(:,1),FFA_W3_600_ds(:,3),alpha*180/pi);
Cd_t_c(6) = interp1(cylinder_ds(:,1),cylinder_ds(:,3),alpha*180/pi);

%Find the drag coefficient for the actual airfoil
Cd = interp1(t_c_vector,Cd_t_c,t_c);  

end

