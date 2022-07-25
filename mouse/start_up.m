clear
clc
arcs = load('arcs.mat');
arcs = arcs.arcs_p1C1;

nodes = load('nodes.mat');
nodes = nodes.nodes_PP_p1C1;

terms = nodes(nodes(:, 5) == 1, :);
[~, p] = min(terms(:, 4));
inlet = terms(p, 1);