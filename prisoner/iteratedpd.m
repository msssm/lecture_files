%% Iterates the Prisoner Dilemma between two players
% 
% Returns four arguments: the two lists of strategies (0=defect, 1=coop)
% and the two scores. 

function [X,Y,Xscore,Yscore]=iteratedpd(r,p1strat,p2strat,payoff)

% Init
mdefect=payoff(1,1);
mcoop=payoff(2,2);
suckerlose=payoff(1,2);
suckerwin=payoff(2,1);

X=[];
Y=[];
Xscore=0;
Yscore=0;

for i=1:r

    % Determine the next move based on the past history
    newX=play(X,Y,p1strat);
    newY=play(Y,X,p2strat);

    % Add the last move 
    X=[X,newX];
    Y=[Y,newY];

    % Update the score
    if (newX==0) %P1 defect
        if(newY==0)
            Xscore=Xscore+mdefect;
            Yscore=Yscore+mdefect;
        else
            Xscore=Xscore+suckerwin;
            Yscore=Yscore+suckerlose;
        end
    else %P1 cooperate
        if(newY==0)
            Xscore=Xscore+suckerlose;
            Yscore=Yscore+suckerwin;
        else
            Xscore=Xscore+mcoop;
            Yscore=Yscore+mcoop;
        end
    end
end
end



    