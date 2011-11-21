% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

function vectorize_local_example(init)


    % Compute the total number of combinations
    %nCombinations = size(init.model.param_A,2)*size(init.model.param_B,2) ...

    simCount=1; % counter of all simulations within a Run

    % Target: nest several loops to simulate different parameter sets


    for i1=1:size(init.model.param_A,2)
        param_A = init.model.param_A(i1);

        for i2=1:size(init.model.param_B,2)
        param_B = init.model.param_B(i2);

            % Repeat the same simulation RUNS times
            for rCount=1:init.RUNS


                fprintf('\n%s\n',init.simName);
                fprintf('Starting Run: %d/%d of Simulation n. %d/%d:\n', ...
                        rCount,RUNS,simCount,nCombinations)
                fprintf('------------------------------------\n');
                fprintf('%+15s = %d\n','PARAM A', param_A);
                fprintf('%+15s = %2f\n','PARAM B', param_B);
               
       
                fprintf('------------------------------------\n');

                simulation(init.globals, param_A, param_B);

                
                fprintf('\n\n');

            end % End n runs with identical param set

            simCount=simCount+1; %updating the simulations count

    end  

end