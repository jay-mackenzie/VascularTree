load seg.mat
load ./data/edges.dat
load path.mat
load vasc.dat

all_edges = [edges(:, 1); edges(:, 2)];
tab(:, 1) = unique(all_edges)';
count = 1;
for i = unique(all_edges)'
    tab(count, 2) = sum(i == all_edges);
%     break
count = count+1;
end

%% find inlet
for i = 1:length(path)
    if length(path{i}) == 1
        inlet_pt = i
        break
    end
end

for i = 1:length(seg)
    if seg{i}(1) == inlet_pt
        inlet_seg = i
        break
    end
end

gen = sortGens(100, seg, inlet_pt);

%% make list of terms in same indexing as used in segs
old_terms = tab(tab(:, 2) == 1, 1)';
count = 1;
new_terms = -ones(size(old_terms));
for i = old_terms
%     find(i == unique(all_edges))
    new_terms(count) = find(i == unique(all_edges));
    count = count+1;
%     break
end

%% segments of ord O.
clc
ords = -ones(size(seg));
figure;
for i = 1:length(seg)
    if intersect(seg{i}, new_terms)
        plotthree(vasc(seg{i}, :), 'k-'); hold on 
        ords(i) = 0;
    end
end
ords(inlet_seg) = -1; % reset the order of the inlet
unassigned = find(ords == -1);

strahler_plt(gen, ords);
%% segments of higher ord.
clc
for i = length(gen):-1:1
    for j = 1:length(gen{i})
        if sum(gen{i}(j) == unassigned) == 1 % if == 1, then is unassigned
            fnl = seg{gen{i}(j)}(end);
            
            daughter_ords = [];
            
            for k = gen{i+1}
                if seg{k}(1) == fnl
                    daughter_ords = [daughter_ords ords(k)];
                end
            end
            
            if length(unique(daughter_ords)) == 1 && sum(daughter_ords == -1) == 0
                ords(gen{i}(j)) = daughter_ords(1)+1;
            else
                ords(gen{i}(j)) = max(daughter_ords);
            end
        end
    end
end

% strahler_plt(gen, ords);
%%
plt_strahler_tree(ords, vasc, gen, seg, 2)
%
function strahler_plt(gen, ords)
    figure; clf; hold on
    map = colormap("spring");

    map = map(floor(linspace(1, length(map), max(ords)+1)), :);


    for i = 1:length(gen)
%     ords(gen{i})
        for j = 1:length(ords(gen{i}))
%         plot(j, i, marker(ords(gen{i}(j))))
            if ords(gen{i}(j)) == -1
                plot(j, i, 'k.', 'MarkerSize',5)
            else
                plot(j, i, '.', 'Color',map(ords(gen{i}(j))+1, :), 'MarkerSize',ords(gen{i}(j))+5)
            end
        end
    end

    set(gca, 'YDir','reverse')
end


function plt_strahler_tree(ords, vasc, gen, seg, filter)
    figure; clf; hold on
    map = colormap("spring");

    map = map(floor(linspace(1, length(map), max(ords)+1)), :);

    for i = 1:length(seg)
        if ords(i) > filter
            plot3(vasc(seg{i}, 1), vasc(seg{i}, 2), vasc(seg{i}, 3),...
            'Color',map(ords(i)+1, :), 'LineWidth',ords(i)+1)
%     ords(i)
        end
    end
    axis off image
    view(3)
end