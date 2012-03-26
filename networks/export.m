%% Define example adiacency matrix

A = [ 1 0 1 0 0 0 1 0 ;
      1 0 0 0 1 0 1 1 ;
      0 1 0 0 0 0 0 1 ;
      0 1 1 0 0 0 1 1 ;
      1 0 1 0 0 0 1 1 ;
      0 0 0 1 1 0 1 0 ;
      0 0 0 1 0 1 0 0 ;
      1 0 0 0 0 0 0 1 ];


%% Save the matrix to a csv file
csvwrite('adjacency.csv',A);

%% Define the same matrix as an adiacency list
% Notice: every vector starts with the node id

A = [1 1 3 7];
B = [2 1 5 7 8];
C = [3 2 8];
D = [4 2 3 7 8];
E = [5 1 3 7 8];
F = [6 4 5 7];
G = [7 4 6];
H = [8 1 8];


network = {A;B;C;D;E;F;H;G};

%% Save the edge list to a csv file
cell2csv('edgelist.csv', network);