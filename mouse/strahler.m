% run start_up.m
% load new_nodes.mat
% new_nodes = add_cols(nodes, inlet)
% new_nodes = find_parents(arcs, new_nodes, inlet)

% save nodes
% load nodes.mat
%%
for i = new_nodes(new_nodes(:,5) ~= 1, 1)'
    new_nodes(find(new_nodes(:, 7) == i), :)
    if length(find(new_nodes(find(new_nodes(:, 7) == i), 6) == 0)) > 1
        new_nodes(find(new_nodes(:, 7) == i), :)
        
        new_nodes(new_nodes(:, 1) == i, 6) = 1;
    end
    
end

%%

t = new_nodes(new_nodes(:, 6) == 0, 1:4);
plot3(t(:, 2), t(:, 3), -t(:, 4),'o')
hold on

for i = 1:length(arcs)
   arcs{i}
   break
end
%%

function nodes = add_cols(nodes, inlet)

nodes = [nodes -ones(length(nodes), 1) -ones(length(nodes), 1)];

nodes(find(nodes(:, 5) == 1), 6) = 0;
nodes(find(nodes(:, 1) == inlet), 6) = -1; %% assert root node
end

function nodes = find_parents(arcs, nodes, inlet)

for i = nodes(:, 1)'
    for j = 1:length(arcs)
        if length(intersect(arcs{j}(1, 1:2), i))
            parent = setminus(arcs{j}(1, 1:2), i);
            nodes(find(nodes(:, 1) == i), 7) = parent;
        end
%         break
    end
    
    
%     break
end

nodes(find(nodes(:, 1) == inlet), 7) = -1; %% assert root node
end

function lst = setminus(lst, to_rm) % removes an element from a vector
    for i = to_rm
        lst = lst(lst ~= i); 
    end
end