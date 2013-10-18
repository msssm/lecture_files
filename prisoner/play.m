%% Play a round of Prisoner Dilemma
% Evaluate previous history and execute a strategy. 
%
% Returns 1 to cooperate or 0 to defect.
% 
% Strategies implemented:
%
% * 1 = always defect
% * 2 = always cooperate
% * 3 = Tit-for-tat
% * 4 = GRIM (defect forever if opponent ever defects)
% * Any other input implements RANDOM- 50% chance of either.

function x=play(player,opp,strategy) 

if (strategy == 1) %always defect
    x=0;
    
elseif (strategy == 2) %always cooperate
    x=1;
    
elseif(strategy==3) %titfortat
    if(isempty(opp))
        x=1; % Be nice first
    else
        x=opp(length(opp)); % Repeat last opponent's move
    end
    
elseif(strategy==4) %GRIM
    if(isempty(opp)) % Be nice first
        x=1;
    else
        if(sum(opp)<length(opp)) % After one defect, always defect
            x=0;
        else
            x=1;
        end
    end

else % random
    s=rand(1,1);
    
    if (strategy==5)
        threshold = 0.5;
    else
        threshold = 0.9;
    end
    
    if(s<threshold)
        x=0;
    else
        x=1;
    end
end