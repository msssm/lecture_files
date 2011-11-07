% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011


% Generate random networks of different size,
% compute average path length,
% compute global clustering coefficient,
% compute giant component threshold,
% plot the average results over N=iter simulation.

clear
clc

from=10;
to=500;
step=10;
P=0.1;

iter=20;


len=(to-from)/step + 1;
v = zeros(1,len);
g = zeros(1,len);
t = zeros(1,len);

for j=1:iter
    idx=1;
    for i=from:step:to
        m = random_graph(i,P);
        apl = average_path_length(m);
        gcf = global_clustering_coefficient(m);

        v(1,idx) = v(1,idx) + apl;
        g(1,idx) = g(1,idx) + gcf;

        t(1,idx) = t(1,idx) + 1/i;

        idx=idx+1;

    end
    display(j)
end

v = v./iter;
g = g./iter;
t = t./iter;

% Find out when the threshold has been passed
idx = find((t < P), 1, 'first');

% Get the handle of the figure
h = figure();

subplot(3,1,1);
plot(v);
title('Avg Path Length');
if (~isempty(idx))  
    ylim=get(gca,'ylim');
    line([idx;idx],ylim.',...
         'linewidth',2,...
         'color','r');
end

subplot(3,1,2);
plot(g);
title('Avg Clustering Coefficient');
if (~isempty(idx))  
    ylim=get(gca,'ylim');  
    line([idx;idx],ylim.',...
         'linewidth',2,...
         'color','r');
end

subplot(3,1,3);
plot(t);
title('Giant Component Threshold');
if (~isempty(idx))  
    ylim=get(gca,'ylim');  
    line([idx;idx],ylim.',...
         'linewidth',2,...
         'color','r');
end