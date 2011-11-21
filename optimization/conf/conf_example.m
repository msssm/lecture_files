% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

%%%%%%%%%%%%%
% GLOBAL Conf
%%%%%%%%%%%%%

simName = 'MyCoolSym';  % or use the routine time2name()
descr   = 'Here I am going to test this and this';
version = 1;
dumpDir = 'dump/';      % or use the routine to generate a unique dir

VIDEO = 0;              % Display real time video
DEBUG = 0;              % Output more verbose 
DUMP = 1;               % Save the results in an external file

COMPUTATION = 0;        % In case you have different engine (e.g. cluster, 
                        % multicore processor, or single core processor)
                        
RUNS = 10;              % Number of simulation runs with same param set

globals = struct('dumpDir', dumpDir, ...
                  'RUNS', RUNS, ...
                  'VIDEO', VIDEO, ...
                  'DEBUG', DEBUG, ...
                  'DUMP', DUMP ...
                  );

%%%%%%%%%%%%%
% MODEL Conf
%%%%%%%%%%%%%

% It is often convenient to define the model parameters as vectors of
% parameters ranges. This way we prepare already the data in an appropriate
% format to perform parameter sweeping


dts = [0.01];          % time_step
steps = [2];          % number of simulation steps
n_agents = [30];       % number of agents

% param_A = [1:0.2:2];
% param_B = [0.1:0.1:0.5];
% ...

model = struct('dts', dts, ...
               'steps', steps, ...
               'n_agents', n_agents ...
                );
                
            
%%%%%%%%%%%%%%%%%%
% Put all together
%%%%%%%%%%%%%%%%%%

init = struct('name', simName, ...
              'descr', descr, ...
              'version', version, ...
              'globals', globals, ...
              'model', model ...
              );
          
save(simName); % Creates a loadable file 