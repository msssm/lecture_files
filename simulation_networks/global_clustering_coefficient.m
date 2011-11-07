% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Authors: Stefan Brugger and Cristoph Schwirzer, 2011

function C = global_clustering_coefficient(A)
% Calculate the global clustering coefficient of a graph.
% (see http://en.wikipedia.org/wiki/Clustering_coefficient for a definition)
%
% INPUT
% A: [n n]: adjacency matrix
%
% OUTPUT
% C: [1]: global clustering coefficient
%
% This function makes use of the Parallel Computing Toolbox, i.e. the outer loop
% can be divided among several workers.

n = size(A, 1);
Cs = zeros(n, 1);
parfor i = 1:n
    Cs(i) = local_clustering_coefficient(A, i);
end
C = sum(Cs) / n;

end % global_clustering_coefficient(...)
