%% better_strahler.m

load seg.mat
load ./data/edges.dat
load path.mat
load vasc.dat
MaxGen = 100;
inlet_pt = path{1}(1);


tree = trifPaths(seg, sortGens(MaxGen , seg, inlet_pt));
trif_gens = sortGens(MaxGen, tree, inlet_pt);
i_seg = find_inlet(tree, inlet_pt);
%%
ords = assign_zeroth(trif_gens, tree);
%%
unassigned = find(ords == -1);
ords = assign_remaining(tree, trif_gens, ords, unassigned);
%%
plt_strahler_tree(ords, vasc, trif_gens, tree, 0)

%%
bif_gens = sortGens(MaxGen, seg, inlet_pt);

i_seg = find_inlet(seg, inlet_pt);
ords = assign_zeroth(bif_gens, seg);

unassigned = find(ords == -1);
ords = assign_remaining(seg, bif_gens, ords, unassigned);
plt_strahler_tree(ords, vasc, bif_gens, seg, 0)


%% assign the remaining orders
function ords = assign_remaining(seg, gens, ords, unassigned)
load vasc.dat
    for i = length(gens):-1:1
        for j = 1:length(gens{i})
            if intersect(gens{i}(j), unassigned)
%             if sum(trif_gens{i}(j) == unassigned) == 1 % if == 1, then is unassigned
                fnl = seg{gens{i}(j)}(end);
                clf; plotthree(vasc(seg{gens{i}(j)}, :), 'r'); hold on
                daughter_ords = [];
                [i j]
                for k = 1:length(gens{i+1})
                    if seg{gens{i+1}(k)}(1) == fnl
                        plotthree(vasc(seg{gens{i+1}(k)}, :), 'g'); hold on
                        daughter_ords = [daughter_ords ords(k)];
                    end
                end


                daughter_ords

                
            % this is wrong: doesn't deal with trifs!
                if length(daughter_ords) == 1
                    ords(gens{i}(j)) = daughter_ords(1);
                elseif length(daughter_ords) == 2
                    if length(unique(daughter_ords)) == 1
                        ords(gens{i}(j)) = daughter_ords(1)+1;
                    else
                        ords(gens{i}(j)) = daughter_ords(1);
                    end
                else
                    if length(unique(daughter_ords)) == 1
                        ords(gens{i}(j)) = daughter_ords(1)+1;
                    else
%                         daughter_ords
                        if sum(daughter_ords == max(daughter_ords)) == 1
                            ords(gens{i}(j)) = max(daughter_ords);
                        else
                            ords(gens{i}(j)) = max(daughter_ords)+1;
                        end
%                         ords(gens{i}(j))
%                         pause
                    end
                end
                
                ords(gens{i}(j))

                pause

                
            end
        end
    end 
end

%% function to assign order 0 to all terminal segments
function ords = assign_zeroth(g, s)

    ords = -ones(size(s));

    for i = 1:length(g{length(g)}); ords(g{length(g)}(i)) =0; end

    for i = 1:length(g)-1
        for j = 1:length(g{i})
            fnl = s{g{i}(j)}(end);
            d = [];
            for k = 1:length(g{i+1})
                strt = s{g{i+1}(k)}(1);
            
                if fnl == strt; d = [d; k]; end
            end

            if isempty(d); ords(g{i}(j)) = 0; end
        end
    end
end
%% functions
function inlet_seg = find_inlet(seg, inlet_pt)
    for i = 1:length(seg)
        if seg{i}(1) == inlet_pt; inlet_seg = i; break; end
    end
end

function tab = make_tab(edges)
    all_edges = [edges(:, 1); edges(:, 2)];
    tab(:, 1) = unique(all_edges)'; 
    count = 1;
    for i = unique(all_edges)'
        tab(count, 2) = sum(i == all_edges);
        count = count+1;
    end

    tab = [tab(:, 1) [1:length(tab)]' tab(:, 2)];
    
end



function plt_strahler_tree(ords, vasc, gen, seg, filter)
    figure; clf; hold on
%     map = colormap("spring");

%     map = map(floor(linspace(1, length(map), max(ords)+1)), :);
    map = unique(colormap('lines'), 'rows');

    for i = 1:length(seg)
        if ords(i) >= filter
            plot3(vasc(seg{i}, 1), vasc(seg{i}, 2), vasc(seg{i}, 3),...
            'Color',map(ords(i)+1, :), 'LineWidth',ords(i)+1)
%     ords(i)
        end
    end
    axis off image
    view(3)
end