function [seg, inlet, bifNodes, endpaths, endNodes, connectedEdges] = load_and_sort(path, edges)
% path = struct2cell(load("path.mat")); path = path{1};

%% find ID of inlet node
for i = 1:length(path)
    if length(path{i}) == 1; inlet = i; break; end;
end
%%

% load edges.dat

ListAllIDs = sort(unique(([unique(edges(:, 1)); unique(edges(:, 2))])));
% ListAllIDs = sort(ListAllIDs);
if max(ListAllIDs) ~= length(ListAllIDs); "still got disconnects", end

%% connected vs disconnected frameworks
% there are 17904 in the connected frame work, and 17945 in the disonnected
% frame work. The list of edges is in the disconnected frame work, but we
% need it in the connected one.
% the list of connected node IDs connected == 1:17904.
% I want to make a list of connected edges, which ammounts to finding the
% position in the list of all IDs of each index.
% this takes approx. 1 s.

connectedEdges = -ones(size(edges));
for i = 1:length(edges)
    for j = 1:2
        connectedEdges(i, j) = find(ListAllIDs == edges(i, j));
    end
end

% save -ascii connectedEdges.dat connectedEdges
edges = connectedEdges;
clear i j ListAllIDs
%% count the instances of each node in the list of edges
count = -ones(max([max(edges) max(edges)]), 1);

for i =1:length(count)
    count(i) = length(find(edges(:, 1) == i))+length(find(edges(:, 2) == i));
end

%% make lists of end nodes and edge nodes, and select the paths to the end nodes
endNodes = find(count == 1);
bifNodes = find(count > 2);
endpaths = path(endNodes);


if isfile("seg.mat")
    load seg.mat
else
%% seperate the paths into segments.
tic
kk = 1;
for j = 1:length(endpaths)
    if j ==1; split = [1]; k = 2; else; split = []; k = 1; end
    
    % list the indices of junction nodes in each path
    for i = 1:length(endpaths{j})
        if find(bifNodes == endpaths{j}(i))
            find(endpaths{j}(i) == bifNodes); split(k) = i; k = k+1;
        end
    end
    
    % include the terminal node
    split = [split length(endpaths{j})];
    
    for i = 1:length(split)-1
        a{kk} = endpaths{j}([split(i):split(i+1)]); kk = kk +1;
    end
    
end


%% remove redundant segments
% the cell array a contians 40561 segments, but many of these are repeats
% which we want to remove 
len = []; for i = 1:length(a); len(i) = length(a{i}); end; len = sort(unique(len));

c = 1;
for j = 1:length(len)
    to_cf = [];
    for i = 1:length(a)
        if length(a{i}) == len(j); to_cf = [to_cf; i]; end
    end
    clear i

    vector = []; for i = 1:length(to_cf); vector = [vector; a{to_cf(i)}]; end
    clear i
    vector = unique(vector,'rows');
    
    [r, ~] = size(vector);
    
    for i =1:r; seg{c} = vector(i, :); c = c+1; end
    
    clear vector i to_cf
    
end

save seg.mat seg

end