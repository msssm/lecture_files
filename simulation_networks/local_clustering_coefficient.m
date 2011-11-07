% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Authors: Stefan Brugger and Cristoph Schwirzer, 2011

function Ci = local_clustering_coefficient(A, i)
% Calculate the local clustering coefficient of a node in a graph.
% (see http://en.wikipedia.org/wiki/Clustering_coefficient for a definition)
%
% INPUT
% A: [n n]: adjacency matrix
% i: [1]: index of the node the local clustering coefficient is calculated for
%
% OUTPUT
% Ci: [1]: local clustering coefficient

neighbor = find(A(:, i));
m = size(neighbor, 1);
Ci = 0;
if m > 1
    for j = neighbor'
        Ci = Ci + full(sum(A(neighbor, j)));
    end
    Ci = Ci / (m * (m - 1));
end

end % local_clustering_coefficient(...)
