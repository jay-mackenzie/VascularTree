clear all; close all; clc
% min dependency:
% - makeTree
% - - trifPaths
% - - sortGens
% - - rmDisconn
% - - - rmEmpty
% - - seriesJoins
% - - - findterms_new
% - - rmShort
% - - - median_Jay
% - - seriesJoins
% - makeSeptum
% - findunassigned
% - - assign.m
% - assignation_list
% - assignation_list_2
% - plot_subdomains

% PDE tool box; machine learning tool box
% plotthree -- like plot3, but more convenient
% inpolyhedron

addpath ./TreeFunctions
addpath ./VentricleFunctions
addpath ./data

load vasc.dat
load rad.dat
load edges.dat
path = struct2cell(load("path.mat")); path = path{1};

load MeshmixerToGeoBoxElements.dat
load MeshmixerToGeoBoxNodes.dat

[tree, searchfrom, showfrom] = makeTree(0.0,0.8,12,1, rad, vasc, edges, path);
[gen] = sortGens(100, tree, tree{1}(1));
plt_gen(tree, gen, tree{1}(1))


[pts, elts, sc] = makeSeptum(MeshmixerToGeoBoxElements, MeshmixerToGeoBoxNodes, vasc);

run findunassigned.m
run assignation_list.m
run assignation_list_2.m
lst = findNaNs(lst); %% lst contains NaNs. Remove them.
find(lst == -1)
run assignation_list_2.m
save -ascii lst.txt lst

[~, vol] = plot_subdomains(pts, lst)

