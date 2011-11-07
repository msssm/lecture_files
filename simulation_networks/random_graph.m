% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Authors: Stefan Brugger and Cristoph Schwirzer, 2011

function A = random_graph(n, p)
% Generates an undirected random graph (without self-loops) of size n (as
% described in the Erdoes-Renyi model)
%
% INPUT
% n: [1]: number of nodes
% p: [1]: probability that node i and node j, i != j, are connected by an edge
%
% OUTPUT
% A: [n n] sparse symmetric adjacency matrix representing the generated graph

% Note: A generation based on sprandsym(n, p) failed (for some values of p
% sprandsym was far off from the expected number of n*n*p non-zeros), therefore
% this longish implementation instead of just doing the following:
%
%    B = sprandsym(n, p);
%    A = (B-diag(diag(B))~=0);
%

% Idea: first generate the number of non-zero values in every row for a general
% 0-1-adjacency matrix. For every row this number is distributed binomially with
% parameters n and p.
%
% The following lines calculate "rowsize = binoinv(rand(1, n), n, p)", just in a
% faster way for large values of n.

% generate a vector of n values chosen u.a.r. from (0,1)
v = rand(1, n);
% Sort them and calculate the binomial cumulative distribution function with
% parameters n and p at values 0 to n. Afterwards match the sorted random
% 0-1-values to those cdf-values, i.e. associate a binomial distributed value
% with each value in r. Each value in v also corresponds to a value in r:
% permute the values in rowSize s.t. they correspond to the order given in v. 
[r index] = sort(v); % i.e. v(index) == r holds
rowSize = zeros(1, n);
j = 0;
binoCDF = cumsum(binopdf(0:n, n, p));
for i = 1:n
    while j<n && binoCDF(j+1)<r(i)
        j = j + 1;
    end
    rowSize(i) = j;
end
rowSize(index) = rowSize;

% for every row choose the non-zero entries in it
nNZ = sum(rowSize);
I = zeros(1, nNZ);
J = zeros(1, nNZ);
j = 1;
for i = 1:n
    I(j:j+rowSize(i)-1) = i;
    J(j:j+rowSize(i)-1) = randsample(n, rowSize(i));
    j = j + rowSize(i);
end

% restrict I and J to indices that correspond to entries above the main diagonal
% and finally construct a symmetric sparse matrix using I and J
upperTriu = find(I<J);
I = I(upperTriu);
J = J(upperTriu);
A = sparse([I;J], [J;I], ones(1, 2*size(I, 2)), n, n);

end % random_graph(...)
