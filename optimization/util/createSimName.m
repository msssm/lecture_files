% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

function simName = createSimName (simName) 
%  CREATESIMNAME Add a timestamp to the name of the simulation

    if (~isempty(simName))
        simName = [simName '-' time2name()];
    else
        simName = ['noname' '-' time2name()];
    end

end

