% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

%Clear workspace
close all
clear
clc

% Add other directories to path
path(path,'util/'); % Help functions

% Load conf file
load('conf_example');

% You may override some of the configuration options here, immediately
% after loading


% SIMULATE:

vectorize_local_example(init);
% Vectorize
% Execute 
% Save results