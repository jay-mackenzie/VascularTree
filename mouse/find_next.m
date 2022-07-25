% clear all
% close all

% [arc_index, node_index, arcs] = sort_gens(); %% sort the arcs into generations
plt_gens(arc_index, arcs) %% plot the generations

%
function [arc_index, node_index, arcs] = sort_gens()
    % sorts the arcs into generations
    run start_up.m
    
    gen_counter = 1;
    
    arc_index{gen_counter} = find_first(arcs, inlet);

    node_index{gen_counter} = inlet;

search_space = setminus(1:length(arcs), arc_index{gen_counter});
gen_counter = gen_counter + 1;
node_index{gen_counter} = setminus(arcs{arc_index{gen_counter-1}}(1, 1:2), inlet);

len = [length(search_space)];

time = [0 0];
ii = 2;
while length(search_space)~= 0
    node_index{ii+1} = [];
    arc_index{ii} = [];
    for kk = node_index{ii}
        if length(intersect(kk,terms(:, 1))) ~= 1
            [search_space, nexts, ids] = one_junction(search_space, arcs, kk);
            len  = [len length(search_space)];
            node_index{ii+1} = [node_index{ii+1} nexts];
            arc_index{ii} = [arc_index{ii} ids(1:end-1)];
        end
    end
    ii = ii + 1;
end
end

function plt_gens(arc_index, arcs)
    % plot all the gens, but coloured
    map = colormap('parula');
    c_index = floor(linspace(1, 64, length(arc_index)));
    dc = length(map);

    hold on
    for k = 1:length(arc_index)
        for l = arc_index{k}
        
            plot3(arcs{l}(2:end, 1), arcs{l}(2:end, 2), -arcs{l}(2:end, 3), ...
                'Color', map(c_index(k), :))
        end
    end
view(3)
    axis image off
end




function [search_space, nexts, ids] = one_junction(search_space, arcs, curr)
    % collects branches from a node
    next = -1;
    nexts = [];
    ids = [];
    while next~=-2
        [search_space, next, id] = find_one(search_space, arcs, curr);
        ids = [ids id];
        nexts = [nexts next];
    end
    nexts = nexts(1:end-1);
end

function [search_space, next_node, next_id] = find_one(search_space, arcs, curr)
    % finds one branch from a node
    init_size = length(search_space);
    next_id = 0;
    for j = search_space
        if intersect(arcs{j}(1, 1:2), curr)
            next_node = setminus(arcs{j}(1, 1:2), curr);
            next_id = j;
            search_space = setminus(search_space, j);
            break
        end
    end
    
    if init_size == length(search_space)
        next_node = -2;
    end
    
end




function [i] = find_first(arcs, inlet) % finds the inlet node
    for i = 1:length(arcs)
        if intersect(arcs{i}(1,1:2),inlet); i; break; end    
    end
end