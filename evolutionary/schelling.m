% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

function [grid] = schelling() 
    clc
    clear

    %% Init

    time = 100;               % simulation time
    N = 20;                 % grid size
    vacancies = 0.4;        % percentage of empty houses in the neighborhood
    fReds = 0.5;            % average fraction of reds in the population

    grid = zeros(N);        % the neighborhood
    updated = zeros(N);     % reference to updated cells

    delta = 0.8;            % differential preference for integrated neighborhood 
    alpha = 1;              % percentage of the population group seeking new house
    beta = 0.5;             
    
    figure;
    colormap([0 0 0; 1 0 0; 0 0 1]);    % Define colors: Red, Green, Blue 

    
    % Random initial positioning
    indexes = randperm(N); 
    for i=1:N
        x = indexes(i);
        for j=1:N
            y = indexes(j);
            if (rand(1) > vacancies)
                if (rand(1) > fReds)
                    grid(x,y) = 1;
                else
                    grid(x,y) = 2;
                end
            end
        end
    end

    % Compute current Neighborhood houses values
    houseValues = computeHouseValues(grid,delta);
    plotNeighborhood(grid,houseValues);

    
    %% main loop, iterating the time variable, t
    for t=1:time

        % Generate random 1*N permutations
        % to perform efficient random update
        indexes = randperm(N); 

        % iterate over all cells in grid x, for index i=1..N and j=1..N
        for i=1:N
            x = indexes(i);
            for j=1:N
                y = indexes(j);
                y
                houseValues(x,j) = computeHouseValue(grid,x, y,grid(x,y),delta);
                        
      
                % somebody is living there
                % and has not yet been updated
                if ( updated(x,y) == 0 && grid(x,y) ~= 0)
                    p = rand(1);
                    if ( p < alpha) % seeking house 

                        found = false;
                        while (~found)
                            house_x = randi(N);
                            house_y = randi(N);

                            if (house_x ~= x || house_y ~= y)
                                found = true;
                            end
                        end


                        valueBuyer  = computeHouseValue(grid,house_x, house_y, grid(x,y), delta);
                        valueSeller = computeHouseValue(grid,house_x, house_y, grid(house_x,house_y), delta);


                        % switch houses
                        if (valueBuyer > valueSeller)
                            updated(x,y) = 1;
                            updated(house_x,house_y) = 1;
                            tmp = grid(x,y);
                            grid(x,y) = grid(house_x,house_y);
                            grid(house_x,house_y) = tmp;
                            plotNeighborhood(grid,houseValues);
                        end

                    end
                    
                    

                end
            end
        end
  
        %plotNeighborhood(grid);
        updated = zeros(N);
    end
end

function value = computeHouseValue (grid, x, y, type, delta)

    if (type == 0) % Nobody is living there
        value = 0;
    else
        
        % Define the Moore neighborhood, i.e. the 8 nearest neighbors
        neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];

        N = length(grid);

        % Iterate over the neighbors  
        for k=1:8
            ngbr_r = x + neigh(k, 1);
            ngbr_c = y + neigh(k, 2);

            reds = 0;

            % Check that the cell is within the grid boundaries
            if (ngbr_r >= 1 && ngbr_c >= 1 && ngbr_r <= N && ngbr_c <= N)
                % count the number of neighbors who are red
                if (grid(ngbr_r,ngbr_c) == 1)
                  reds = reds + 1;
                end
            end 
        end

        f = reds / length(neigh); % fraction of reds

        if (type == 1)
            value = 0.5 * (f - delta) - 0.5 * (f - delta)^2;
        else
            value = 0.5 * (f + delta) - 0.5 * (f + delta)^2;
        end
    end

end

function values = computeHouseValues (grid, delta)

    N = length(grid);
    values = zeros(N);
    
    % Define the Moore neighborhood, i.e. the 8 nearest neighbors
    neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];
    
    for x=1:N
        for y=1:N
            values(x,y) = computeHouseValue(grid,x, y,grid(x,y),delta);
        end
    end

end

function value = computeAvgPriceValue (grid)
    value = mean(mean(grid));
end

function plotNeighborhood (grid,houseValues)
    
    imagesc(grid, [0 2]);             % Display grid
    pause(0.01);                         % Pause for 0.01  
end
