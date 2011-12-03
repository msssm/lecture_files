% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

clc
clf
clear
hold on
delta = 0.1;

%% Plot price functions

syms x
fx_h = @(x) 0.5*(x+delta)-0.5*(x+delta)^2;
fy_h = @(x) 0.5*(x-delta)-0.5*(x-delta)^2;
interval = [0 1];


fplot(fx_h,interval,'b');
fplot(fy_h,interval,'r');
legend('X', 'Y');
title('House price as a function of the fraction of X in the neigh.','FontSize', 16);
ylim([0,0.16]);
xlim([0,1]);
box on;
grid on;
set(gca, 'FontSize', 16); 
ylabel('Price', 'FontSize', 16); 
xlabel('Percentage of X in the neigh.','FontSize', 16); 

hold off

%% Compute derivatives

figure
hold on
omega = 1;
beta = 1;
ds = [];
for delta=0:0.1:1
    fx = 0.5*(x+delta)-0.5*(x+delta)^2;
    fy = 0.5*(x-delta)-0.5*(x-delta)^2;
    rep_eq = omega*x*(1-x)*beta*(fx-fy);
    d = diff(rep_eq);
    if (d == 0)
        d = [0;0];
    else
        d = double(solve(d));
    end
    ds = [ds d];
end

plot([0:0.1:1],ds);

