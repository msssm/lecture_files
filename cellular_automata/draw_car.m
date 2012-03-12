% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti and Karsten Donnay, 2012

function draw_car(x0, y0, w, h);
% This function is drawing a car
% INPUT: 
%   x0, y0: Central point of the car
%   w: Width of the car
%   h: Height of the car


% Hold the graphics
hold on


% Define the coordinates for the car chassi
chassi_x = [w/2 w/2 2*w/6 w/6 -2*w/6 -w/2 -w/2];
chassi_y = [0 h/2 h/2 h h h/2 0];


% Define the coordinates for the wheels
angles = 0:0.1:(2*pi);
r = sqrt(w*w + h*h)/10;
wheel_x = r*cos(angles);
wheel_y = r*sin(angles);


% Draw the car!
patch(x0+chassi_x, y0+chassi_y, 'r')
patch(x0-w/4+wheel_x, y0+wheel_y, 'k')
patch(x0+w/4+wheel_x, y0+wheel_y, 'k')
