% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti, 2011

function [grid] = schelling() 
    clc
    close all
    clear

    %% Init

    time = 100;             % simulation time
    N = 100;               % grid size
    vacancies = 0.2;        % percentage of empty houses in the neighborhood
    fReds = 0.5;            % average fraction of reds in the population

    

    delta = 0.2;            % tolerance limit 
    alpha = 1;              % percentage of the population group seeking new house
      
    grid = generateRandomGrid(N,vacancies,fReds); % the neighborhood
    updated = zeros(N);     % reference to updated cells
    
    % Get the handle of the figure
    h = figure();
    
    % Prepare the new file.
    vidObj = VideoWriter('schelling.avi');
    open(vidObj);

    plotNeighborhood(grid);
    
    %% main loop, iterating the time variable, t
    for t=1:time

        % Generate random 1*N permutations
        % to perform efficient random update
        indexes_x = randperm(N); 
        indexes_y = randperm(N); 
        % iterate over all cells in grid x, for index i=1..N and j=1..N
        for i=1:N
            
            for j=1:N
                x = indexes_x(mod(i+j,N)+1);
                y = indexes_y(j);
             
                %houseValues(x,y) = computeHouseValue(grid,x, y,grid(x,y),delta);
                
                % somebody is living there
                % and has not yet been updated
                if ( updated(x,y) == 0 && grid(x,y) ~= 0)
                    
                    frac = getFracOtherNeighbours(grid,x,y, grid(x,y));
                    
                    if (frac > delta) % individual is unhappy
                    
                        p = rand(1);
                        if ( p < alpha ) % on update state

                           [house_x,house_y] = findGoodSpot(grid,x,y,grid(x,y),delta);

                            if (house_x ~= 0)
                                updated(x,y) = 1;
                                updated(house_x,house_y) = 1;
                                tmp = grid(x,y);

                                grid(x,y) = grid(house_x,house_y);
                                grid(house_x,house_y) = tmp;

                                %plotNeighborhood(grid);
                               

                            end
                       
                        end
                    end
                end
            end
        end
        
        plotNeighborhood(grid);
        % Get the very last frame    
        currFrame = getframe(h);
        writeVideo(vidObj,currFrame);
        updated = zeros(N);
    end
    
    % Close the video file.
    close(vidObj);
end

function grid = generateRandomGrid(N,vacancies,fReds)

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

end

function ok = isValidMove (grid, new_x, new_y, old_x, old_y)

    ok = 0;
    
    if (new_x ~= old_x || new_y ~= old_y) 
        if (grid(new_x, new_y) == 0)
            ok = 1;
        end
    end

end


function ok = isWithinGrid (grid, x, y)
    ok = 0;
    N = length(grid);
    if (x >= 1 && y >= 1 && x <= N && y <= N)
        ok = 1;
    end
end


function v = findMooreNeighborhood (grid, x, y, order)

    %x
    %y
    %order
    startX = x - order;
    startY = y - order;
    endX = startX + 2*order;
    endY = startY + 2*order;
    lenH = order*2;
    lenV = order*2-1;
    v = [];
    top = [];
    bottom = [];
       
    % First and last row
    for i=0:lenH
        X = startX+i;
        if (isWithinGrid(grid,X,startY) && isValidMove(grid, X, startY, x, y))
            top = [top ; [X,startY]];
        end
        
        
        if (isWithinGrid(grid,X,endY) && isValidMove(grid, X, endY, x, y))
            bottom = [bottom ; [X,endY]];
        end
        
    end
    
    %2 lateral columns
    for i=1:lenV
        Y = startY+i;
        if (isWithinGrid(grid,startX,Y) && isValidMove(grid, startX, Y, x, y))
            v = [v ; [startX,Y]];
        end
        if (isWithinGrid(grid,endX,Y) && isValidMove(grid, endX, Y, x, y))
            v = [v ; [endX,Y]];
        end
    end
    
    v = [top ; v ; bottom];
end

function [X,Y] = findGoodSpot(grid, x, y, type, delta)
    
    %x
    %y

    X = 0;      % not found
    Y = 0;      % not found
    found = 0;
    order = 1;    % multiplier for Moore Neighborhood
    N = length(grid);
    maxOrder = abs(max([(x-N),(N-x),(y-N),(N-y)]));
    
    while (~found)
    
        neigh = findMooreNeighborhood(grid, x,y,order);
        N = size(neigh,1);
        indexes = randperm(N);
        % Iterate over the neighbors  
        for k=1:N
            X = neigh(indexes(k), 1);
            Y = neigh(indexes(k), 2);
            
            
            f = getFracOtherNeighbours(grid,X,Y,type);

            if (delta > f)
                found = 1;
                continue;     
            end
        end
        
        order = order + 1;
        if ( order > maxOrder )
            X = 0;
            Y = 0;
            found = 1; 
            continue;
        end
    end
    
    
end


function f = getFracRedNeighbours(grid, x, y)
    [c,f] = analyzeNeighborhood(grid, x, y);
end

function c = getCountRedNeighbours(grid,x,y)
    [c,f] = analyzeNeighborhood(grid, x, y);
end

function f = getFracOtherNeighbours(grid,x,y,type)
    [c,f] = analyzeNeighborhood(grid, x, y);
    if (type == 1)
        f = 1 - f;
    end
end

function [reds,frac] = analyzeNeighborhood(grid, x, y)

    % Define the Moore neighborhood, i.e. the 8 nearest neighbors
    neigh = [-1 -1; 0 -1; 1 -1; 1 0; 1 1; 0 1; -1 1; -1 0];  
    frac = 0;
    reds = 0;
    count = 0;
    % Iterate over the neighbors  
    for k=1:8
        ngbr_r = x + neigh(k, 1);
        ngbr_c = y + neigh(k, 2);
       
        % Check that the cell is within the grid boundaries
        if (isWithinGrid(grid, ngbr_r, ngbr_c))
            % count the number of neighbors who are red
            if (grid(ngbr_r,ngbr_c) ~= 0)
                count = count+1;
                if (grid(ngbr_r,ngbr_c) == 1)
                  reds = reds + 1;
                end                   
            end
        end 
    end

    if (reds > 0)
        frac = reds / count;
    end
end

function plotNeighborhood (grid)
    imagesc(grid, [0 2]);               % Display grid
    colormap([1 1 1; 1 0 0; 0 0 1]);    % Define colors: Red, white, Blue
    pause(0.01);                        % Pause for 0.01  
end
