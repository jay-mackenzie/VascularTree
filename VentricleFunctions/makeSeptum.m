function [pts, elts, sc] = makeSeptum(elt, node, vasc)


% addpath ../functions
% addpath ../JaysFunctions/
% addpath ../dataFiles/
% run loadData.m

% load vasc.dat

% smooth ventricular mesh
tetra = elt(:, 2:5); % remove prepended 4's
tetra = tetra+1; % matlab indexes from 1, where as meshmixer does it from 0
XYZ = node; % surface nodes
%% shift the apex to the origin
[~, p] = min(XYZ(:, 3));
xshift = XYZ(p, 1); yshift = XYZ(p, 2); zshift = XYZ(p, 3);
XYZ(:, 1) = XYZ(:, 1)- xshift; XYZ(:, 2) = XYZ(:, 2)- yshift;
XYZ(:, 3) = XYZ(:, 3)- zshift;

%% make a triangular mesh
a = 1:length(XYZ);
[tri, vent_vol] = boundary(XYZ(a,:)); %% triangular mesh for inpolyhedron
% figure;
p = [1 1 0];
trisurf(tri,XYZ(a,1),XYZ(a,2),XYZ(a,3),...
    'facecolor', 'c', ...
    'FaceAlpha',0.1, 'Edgecolor', 'm');
axis image off

% tetramesh(tetra(:, :),XYZ,'FaceColor','cyan','FaceAlpha',0.1)
% trisurf is quicker than tetramesh
%% fill shell with randomly distributed points

% stlwrite('myoSurf.stl', tri, XYZ)
model = createpde(1);
importGeometry(model,'myoSurf.stl');
mesh = generateMesh(model,'Hmax',2, 'GeometricOrder', 'linear'); % decrease hmax for finer mesh

pts = mesh.Nodes';
elts = mesh.Elements';

plot3(pts(:, 1), pts(:, 2), pts(:, 3), '.')
% pdeplot3D(model)
%% random fill
% bounds = [min(XYZ), max(XYZ)];
% box_vol = 1; for i = 1:3; box_vol= box_vol*(bounds(i+3)-bounds(i)); end
% 
% N = 100000; % no. points in box
% vent_vol/box_vol*N % approx no. points in vent.
% pts = rand(N, 3); % rand points in box
% for i = 1:3; pts(:, i) = pts(:, i)*(bounds(i+3)-bounds(i))+bounds(i); end
% pts = pts(inpolyhedron(tri,XYZ, pts), :);
% size(pts)
% hold on; plot3(pts(:, 1), pts(:, 2), pts(:, 3), '.')
%% make a hull around the vascular nodes to find where they aren't

% points that are reached by the vasculature
invent = vasc(inpolyhedron(tri,XYZ, vasc), :); 

not_septum = boundary(invent, 1);

% plot that hull
trisurf(not_septum, invent(:, 1), invent(:, 2), invent(:, 3), 'facealpha', 0.5); view(2); axis off image
%% isolate the septum

% nodes outwith the perfused region: septum candidates
sc = pts(~inpolyhedron(not_septum, invent, pts), :);
plot3(sc(:, 1), sc(:, 2), sc(:, 3), '.'); view(2); axis off equal
shrink = 1; %0.75; % shrink factor for making hulls

% manually select a rough septum wedge (optional)
sc = sc(find(sc(:, 2)<5), :);
sc = sc(find(sc(:, 1)<10), :);

% select and remove outer surface until there are no more points
i = 1;
clear outer_surf v
while length(sc)>5
[outer_surf{i}, v(i)] = boundary(sc, shrink);
sc = sc(setdiff(1:length(sc), unique(outer_surf{i}))', :);
% plot3(sc(:, 1), sc(:, 2), sc(:, 3), '.'); view(2); axis off equal; hold on
density(i) = length(sc)/v(i);
i = i+1;
end
[~, p] = max(density);

%% redefine the candidate points, and remove the number of layers that
% maximises septum density
sc = pts(~inpolyhedron(not_septum, invent, pts), :);
% available = pts(inpolyhedron(not_septum, invent, pts), :);
sc = sc(find(sc(:, 2)<5), :);
sc = sc(find(sc(:, 1)<10), :);

for i =1:p
    [os, ~] = boundary(sc, shrink);
    sc = sc(setdiff(1:length(sc), unique(os))', :);
end
[sept_surf, vent_vol] = boundary(sc, shrink);

%% plot the septum and the venticle
figure; trisurf(sept_surf,sc(:,1),sc(:,2),sc(:,3),...
    'FaceColor','magenta','FaceAlpha',1); hold on

trisurf(not_septum,invent(:,1),invent(:,2),invent(:,3),...
    'FaceColor','cyan','FaceAlpha',1); axis off image