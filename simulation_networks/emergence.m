% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011


% Generate random networks of different size,
% compute average path length,
% compute giant component threshold,
% plot the results of the simulation.


clc
clear

from=10;
to=500;
step=10;
P=0.01;

len=(to-from)/step;
v = [1,len];
t = [1,len];
idx=1;
for i=from:step:to
    m = random_graph(i,P);
    apl = average_path_length(m);
    v(1,idx) = apl;
    t(1,idx) = 1/i;
    idx=idx+1;
end

subplot(2,1,1);
plot(v);
title('Average Path Length');
subplot(2,1,2);
hold on
plot(t);
plot(P*ones(1,len),'color','r');
title('Giant Component Threshold');
hold off