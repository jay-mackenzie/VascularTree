%% softmech presentation
close all
clear all

%% nodes
load vasc.dat
load vasc.dat
load edges.dat
load path.mat
[seg, inlet, bifNodes, endpaths, endNodes, newedges] = load_and_sort(path, edges);
%% nodes

% figure;plotthree(vasc, 'k.');
% basis
% savefig('one');close
%% edges

% figure
% for i =[newedges(1:end, :)]'
%     plotthree(vasc(i, :), '-'); hold on
% end
% basis
% savefig('two');close

%% end pts
% figure;plotthree(vasc, 'k.'); hold on
% plotthree(vasc(endNodes, :), 'cs')
% basis
% savefig('three');close
%% path
% figure;plotthree(vasc, 'k.'); hold on
for i = 1:length(path); l(i) = length(path{i}); end
[~, p] = max(l);
% hold on
% plot3(vasc(path{p}, 1), vasc(path{p}, 2),...
%     vasc(path{p}, 3), 'r-', 'LineWidth', 7); 
% basis
% 
% savefig('four');close

%% bif nodes
% figure;plotthree(vasc, 'k.'); hold on
% plotthree(vasc(bifNodes, :), 'r+')
% axis off equal;view([35 0])
% savefig('five');close
%% path split on bif nodes
% figure;plotthree(vasc, 'k.'); hold on
[split, ia, ib] = intersect(bifNodes, path{p});
split = [path{p}(1); split];
% plotthree(vasc(split, :), 'r+'); hold on

for i = 1:length(split); one(i) = find(path{p} == split(i, :));end
one = sort(one);

% for i = 1:length(one)-1
%     plot3(...
%    vasc(path{p}(one(i):one(i+1)), 1),...
%        vasc(path{p}(one(i):one(i+1)), 2),...
%        vasc(path{p}(one(i):one(i+1)), 3),...
%        'linewidth', 7)
% end

% basis
% savefig('six');close
%% all segments
% figure
% for i = 1:length(seg)
%     plotthree(vasc(seg{i}, :), '-'); hold on
% end
% basis
% 
% savefig('seven');close
%% sort into generations
MaxGen = 100;
tree = trifPaths(seg, sortGens(MaxGen , seg, inlet));
gens = sortGens(MaxGen, tree, inlet);
map = colormap('parula');
% treeplt(tree, map, vasc)
markers = ['b-';'g-'; 'r-'; 'c-'; 'm-'; 'k-'];
figure; hold on
for i = 1:length(markers)
    for j = 1:length(gens{i})
        plot3(vasc(tree{gens{i}(j)}, 1), ...
            vasc(tree{gens{i}(j)}, 2), ...
            vasc(tree{gens{i}(j)}, 3), ...
            markers(mod(i-1, length(markers))+1), 'LineWidth', 10-i);
    end
end
basis
view(2)
savefig('eight')

%% filtered tree

load rad.dat


[tree1, searchfrom, showfrom] = makeTree(0.6,0.8,100,1, rad, vasc, edges, path);
basis
savefig('nine')
[tree2, searchfrom, showfrom] = makeTree(0.6,0.5,100,1, rad, vasc, edges, path);
basis
savefig('ten')

[tree3, searchfrom, showfrom] = makeTree(0.5,0.8,5,1, rad, vasc, edges, path);
basis
savefig('eleven')
%%
load myo.dat
bdry = boundary(myo(:, 1), myo(:, 2), myo(:, 3), 1);
figure;

trisurf(bdry, myo(:, 1), myo(:, 2), myo(:, 3), ...
    'edgealpha', 0.75, 'facealpha', 0.75)
basis
view(3)

savefig('twelve')
%%
% [tree3, searchfrom, showfrom] = makeTree(0.5,0.8,5,1, rad, vasc, edges, path);




%% tree outside the myocardium

trisurf(bdry, myo(:, 1), myo(:, 2), myo(:, 3), ...
    'edgealpha', 0.75, 'facealpha', 0.75)
basis
view(3)


FindOutside
tree = trifPaths(outSegs, sortGens(MaxGen , outSegs, inlet));
gens = sortGens(MaxGen, tree , inlet);
% map = colormap('lines');

markers = ['b-';'g-'; 'r-'; 'c-'; 'm-'; 'k-'];

for i = 1:length(gens)
    for j = 1:length(gens{i})
        plotthree(vasc(tree{gens{i}(j)}, :), ...
            markers(mod(i-1, length(markers))+1));
    end
end
basis
view(2)
savefig('thirteen')

