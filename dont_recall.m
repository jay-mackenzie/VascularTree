clear all; close all
marker = {'r', 'g', 'b', 'c', 'm', 'y', 'k'};
load seg.mat
load vasc.dat
load path.mat
for i = 1:length(path);if length(path{i}) ==1;i;break;end;end; inlet_pt = i;
gens = sortGens(100, seg, inlet_pt);

count = 0;
figure
for i = 1:length(marker)
    for j = 1:length(gens{i})
        plotthree(vasc(seg{gens{i}(j)}, :), marker{i}); hold on
    end
    count = count+length(gens{i});
end
count

tree = trifPathsUp(seg, sortGens(100 , seg, inlet_pt));
trif_gens = sortGens(100 , tree, inlet_pt);
figure; 
count = 0;
for i = 1:length(marker)
    for j = 1:length(trif_gens{i})
        plotthree(vasc(tree{trif_gens{i}(j)}, :), marker{i}); hold on
    end
    count = count + length(trif_gens{i});
end
count