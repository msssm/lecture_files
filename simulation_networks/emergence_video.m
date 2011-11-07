% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011


% Generate random networks of different size,
% compute average path length,
% compute global clustering coefficient,
% compute giant component threshold,
% plot the data in real time
% save the plot as an avi video file.

clear
clc

from=10;
to=500;
step=10;
P=0.01;

% Get the handle of the figure
h = figure();

% Prepare the new file.
vidObj = VideoWriter('video.avi');
open(vidObj);

len=(to-from)/step;
v = [1,len];
g = [1,len];
t = [1,len];
idx=1;
for i=from:step:to
    m = random_graph(i,P);
    apl = average_path_length(m);
    gcf = global_clustering_coefficient(m);
    
    v(1,idx) = apl;
    g(1,idx) = gcf;
    
    t(1,idx) = 1/i;
    
    idx=idx+1;
    
    subplot(3,1,1);
    plot(v);
    title('Avg Path Length');
    subplot(3,1,2);
    plot(g);
    title('Avg Clustering Coefficient');
    subplot(3,1,3);
    plot(t);
    title('Giant Component Threshold');
   
    % Get the very last frame    
    currFrame = getframe(h);
    writeVideo(vidObj,currFrame);
    
end

% Find out when the threshold has been passed
idx = find((t < P), 1, 'first');

% Add a vertical line at the time step idx
if (~isempty(idx))  
    subplot(3,1,1);
    ylim=get(gca,'ylim');
    line([idx;idx],ylim.',...
         'linewidth',2,...
         'color','r');

    subplot(3,1,2);
    ylim=get(gca,'ylim');  
    line([idx;idx],ylim.',...
         'linewidth',2,...
         'color','r');

    subplot(3,1,3);
    ylim=get(gca,'ylim');  
    line([idx;idx],ylim.',...
         'linewidth',2,...
         'color','r');

    currFrame = getframe(h);
    writeVideo(vidObj,currFrame);
end

% Close the video file.
close(vidObj);