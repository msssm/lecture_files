%% Runs an IPD (Iterated Prisoner Dilemma) tournament
% Players with different strategies iteratedtly face each others and decide
% to cooperate or defect.

% Strategies are based on the previous history of the game
% The right number of random players can enrich the dynamics of the game

fprintf('\nStart the tournament...\n');
R=200; % number of rounds

%% PLAYERS & STRATEGIES
% Set up 4 players and assign them different strategies
% 1 always defect
% 2 always cooperate
% 3 Tit-for-Tat
% 4 GRIM
% 5 Random 0.5 defect
% 6 Random 0.9 defect
Q=[3,4,5,6]
n=length(Q);

%% MATRIX PAYOFF
% Set up the payoff matrix according to Axelrod (1984) The Evolution of
% Cooperation.
% Notice: 3+3 > 5+0

bothDefect = 1;
bothCooperate = 3;
temptationToDefect = 5;
suckerPayoff = 0;

payoffMatrix = [bothDefect,suckerPayoff;
                temptationToDefect,bothCooperate]

%% START THE TOURNAMENT
%
Z=zeros(n,n); % tournament table

for i=1:n
    for j=1:n
        [hP1,hP2,scoreP1,scoreP2]=iteratedpd(R,Q(i),Q(j),payoffMatrix);
        Z(i,j)=scoreP1; 
    end
end


%% PRINT RESULTS
%
display(Z);
scores = zeros(n,1);
for i=1:n
    scores(i)=sum(Z(i,1:n));
end
display(scores);

imagesc(Z);

% Who wins?
% Why?

