close all;
clear all;

global mass kstiff vo chord span alfageom alfatab cltab cdtab ...
    fstab clinvtab clfstab dynstall

mass=1.0;
kstiff=61.7;
vo=2;
chord = 0.2;
span = 1.0;

alfageom = 12;
dynstall = 1; % use 1 to activate dynamic stall

x=importdata('FFA-W3-241_ds.txt'); [m,n]=size(x);
alfatab=x(:,1);
cltab=x(:,2);
cdtab=x(:,3);
fstab=x(:,5);
clinvtab=x(:,6);
clfstab=x(:,7);

%plot(alfa,cl)

%omeg=sqrt(k/m);
%freq=omega(m,k);
%[t,z]=ode45(@newton2,[0 20],[0.02 0.0 0]);
%plot(t,z(:,1))
%xlabel('time [s]')
%ylabel('x(t) [m]')
%set(gca,'FontSize',14)
%% Plot position vs time for 3 different alfa geom.
geom_array = [0 15 20];

for alfageom = geom_array
    [t,z] = ode45(@newton2, [0 20], [0.02 0.0 0]);
    hold on
    plot(t,z(:,1));
    xlabel('time [s]')
    ylabel('x(t) [m]')
    set(gca, 'FontSize', 14)
end

legend(int2str(geom_array(1)), int2str(geom_array(2)), int2str(geom_array(3)))
hold off

%% 
% for dynstall = [0 1]
%     [t,z] = ode45(@newton2, [0 20], [0.02 0.0 0]);
%     hold on
%     plot(t,z(:,1));
%     xlabel('time [s]')
%     ylabel('x(t) [m]')
%     set(gca, 'FontSize', 14)
% end 
% 
% legend('W/O dyn stall', 'W dyn stall')
