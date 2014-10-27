% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Authors:
% - Stefano Balietti and Karsten Donnay, 2012
% - Tobias Kuhn, 2014

function [density, flow] = simulate_cars_video(moveProb, inFlow)
% This function is simulating cars on a highway
% INPUT: 
%   moveProb: the probability for a car to move forwards, 0..1
%   inFlowProb: The inflow volume to the road, 0..1
% OUTPUT:
%   density: the average vehicle density, 0..1
%   flow: the average flow of cars, 0..1


% set parameter values
N=40;            % road length
nIter=200;      % number of iterations


% define road (1=car, 0=no car)
x = rand(1,N)<inFlow;


% set statistical variables
movedCars=0;
density=0;

% main loop, iterating the time variable, t
for t=1:nIter
    
    % THIS IS WHERE THE MODEL IS

    % save old state of the road
    x0=x;    
    % update position x(0):
    if ( rand<inFlow )
        x(1)=1;
    end
    % update positions x(1..N-1)
    for i=1:(N-1)
        if ( x0(i) && ~x0(i+1) && rand<moveProb)
            x(i)=0;
            x(i+1)=1;
            movedCars=movedCars+1;  % keep track of how many cars are moved forwards. Needed for calculating the flow later on.
        end
    end
    % update position x(N)
    if ( rand<moveProb )
        x(N)=0;
    end


    % update statistics
    density = density + sum(x)/N;

    
    % animate
    clf; hold on;
    plot(0:N, 0*(0:N), 'Color', [.75 .75 .75], 'LineWidth', 5)
    xlim([0 N+1])
    ylim([-N/4 N/4])
    for i=1:N
        if ( x(i) )
            draw_car(i, 0, 0.8, 0.2);
        end
    end
    % STORE VIDEO FRAMES
    % may rise a warning in MATLAB 2011a
    A(t)=getframe();

end


% rescale statistical vaiables before returing them
density = density/nIter;
flow = movedCars/(N*nIter);

% SAVE VIDEO FRAMES TO FILE
movie2avi(A, 'video_cars.avi','fps',60);
