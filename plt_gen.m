function [seg, h] = plt_gen(seg, gen, inlet)
close all; 
load vasc.dat
h = figure;

% MaxGen = 100;
% marker = {'r-', 'b-', 'g-', 'c-', 'm-', 'k-'};
map = colormap('spring');
dc = floor(linspace(1, length(map), length(gen)));



% no_gens = length(map);

% gen = sortGens(MaxGen, seg, inlet);
for i = 1:length(gen)
    for j = 1:length(gen{i})
        if length(gen) > 5
            w = 2;
        else
            w = (length(gen)+1-i)*2;
        end

        plot3(vasc(seg{gen{i}(j)}, 1), vasc(seg{gen{i}(j)}, 2), vasc(seg{gen{i}(j)}, 3),...
            'color', map(dc(i), :), 'linewidth', w); hold on
    end
end
view(2)
axis equal
% tree = trifPaths(seg, sortGens(MaxGen , seg, inlet));

% gens = sortGens(MaxGen, tree, inlet);
% map = colormap('parula');
% % treeplt(tree, map, vasc)
% markers = ['b-';'g-'; 'r-'; 'c-'; 'm-'; 'k-'];
% figure; hold on
% for i = 1:length(markers)
% for j = 1:length(gens{i})
% plot3(vasc(tree{gens{i}(j)}, 1), ...
% vasc(tree{gens{i}(j)}, 2), ...
% vasc(tree{gens{i}(j)}, 3), ...
% markers(mod(i-1, length(markers))+1), 'LineWidth', 10-i);
% end
% end
% basis
% view(2)
end