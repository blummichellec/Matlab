% NAME: Michelle Blum
% DATE: May 5th, 2017
% This code numerically solves the heat equation
% u_t = u_xx for 0<x<pi, t>0
% u(x,0) = phi(x) = 1 + sin (x)

N=60;      % number of time steps
J=20;       % number of partitions
dx=(pi-0)/J;  % size of partition
x=0:dx:pi;
s=0.45;
u= ones(N,J+1);
    % a ones matrix of N rows and J+1 columns
    % after simulation:
    % each row represents u(x,t) at a different time
        
        
phi= @(x) 1 + sin (x); % initial condition
u(1,:) = phi(x); % row 1 is u(x,t) at time t=0 (initial condition)

for n=1:N
    % j=1 and j=J+1 (the boundary conditions) 
    % are unaffected by the loop and remain equal to 1
    for j=2:J  
        u(n+1,j) = u(n,j)+ s*(u(n,j+1)-2*u(n,j)+u(n,j-1));
    end
end

% plot for time steps n= 1,30,60
subplot(2,1,1) % plot 1
plot(x,u(1,:))
axis([0,pi, 1, 2.5])
xlabel ('x', 'Fontsize',15)
ylabel ('u', 'Fontsize',15)
title ('time step = 0', 'Fontsize',15)

subplot(2,2,3) % plot 2
plot(x,u(30,:))
axis([0,pi, 1, 2.5])
xlabel ('x', 'Fontsize',15)
ylabel ('u', 'Fontsize',15)
title (' time step = 30', 'Fontsize',15)

subplot(2,2,4) % plot 3
plot(x,u(60,:))
axis([0,pi, 1, 2.5])
xlabel ('x', 'Fontsize',15)
ylabel ('u', 'Fontsize',15)
title (' time step = 60', 'Fontsize',15)
