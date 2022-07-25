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

% plotthree -- like plot3, but more convenient
% inpolyhedron

%%
clear all; close all; clc

addpath ./functions
load vasc.dat
load rad.dat
load edges.dat
load("path.mat")

load MeshmixerToGeoBoxElements.dat
load MeshmixerToGeoBoxNodes.dat

XYZ = MeshmixerToGeoBoxNodes;
% shift the apex to the origin
[~, p] = min(XYZ(:, 3));
xshift = XYZ(p, 1); yshift = XYZ(p, 2); zshift = XYZ(p, 3);
XYZ(:, 1) = XYZ(:, 1)- xshift; XYZ(:, 2) = XYZ(:, 2)- yshift;
XYZ(:, 3) = XYZ(:, 3)- zshift;

%% make a tree
[tree, searchfrom, showfrom] = makeTree(0.5,0.8,5,1, rad, vasc, edges, path);
%%
% [gen] = sortGens(7, tree, tree{1}(1)); %% plot the first 7 generations

[pts, elts, sc] = makeSeptum(MeshmixerToGeoBoxElements, XYZ, vasc);

run findunassigned.m
run assignation_list.m
run assignation_list_2.m
lst = findNaNs(lst); %% lst contains NaNs. Remove them.
find(lst == -1)
run assignation_list_2.m
save -ascii lst.txt lst

[~, v] = plot_subdomains(pts, lst)


%%
run AHA.m