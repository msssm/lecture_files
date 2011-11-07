% Modeling and Simulating Social Systems with MATLAB
% http://www.soms.ethz.ch/matlab
% Author: Stefano Balietti

function [ arc_list ] = adj2arclist( adj_m )
%ADJ2ARCLIST Summary of this function goes here
%   Detailed explanation goes here


len = length(adj_m);
arc_list = cell(len,1);
for i=1:len
    row = [i find(adj_m(i,:))];
    arc_list{i} = row;
end

end

