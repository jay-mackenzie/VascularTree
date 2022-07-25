%% set filtering parameters
function [tree,searchfrom, showfrom] = makeTree(MinRad, strict, MaxGen, plt, rad, vasc, edges, path)
%% make segments
[seg, inlet, bifNodes, endpaths, ~] = load_and_sort(path, edges);

%% construct a tree from the segments
seg = trifPaths(seg, sortGens(MaxGen , seg, inlet));
gens = sortGens(MaxGen, seg , inlet);

%% First pass of the filter
IDS = [];
for i = 1:length(gens)
    for j = 1:length(gens{i})
%         IN = (sum(rad(tree{j}) >= MinRad)/length(tree {j}) >= strict == 1); % strictness based
        IN = mean(rad(tree{gens{i}(j)})) >= MinRad;


        if IN; IDS = [IDS; j]; end
    end
end

%% prune the tree: remove disconnected and short segments
tree = tree(IDS);
tree = rmDisconn(tree, inlet);
tree = seriesJoins(tree);
tree = rmShort(tree);
tree = seriesJoins(tree);

% figure; treeplt(tree, [0 0 0]);
%% find terminal branches and the points in each to define compartments of perfusion
termNodeId = findterms_new(tree);
termVascPts = vasc(termNodeId, :);

for i = 1:length(tree); temp(i) = tree{i}(end); end
[~, termBranchID] = intersect(temp, termNodeId);
[~, BodyBranchID] = setdiff(temp, termNodeId);
clear temp

c = 1;
for i = termBranchID'
    TermBranches{c} = tree{i};
    searchfrom(c) = TermBranches{c}(2);
    showfrom(c) = TermBranches{c}(end);
    c = c+1;
end

c = 1; for i = BodyBranchID'; BodyBranches{c} = tree{i}; c = c+1; end

if plt == 1
figure; treeplt(TermBranches, [1, 0, 1], vasc)
hold on
treeplt(BodyBranches, [0, 1, 1], vasc)
plot3(vasc(searchfrom, 1), vasc(searchfrom, 2), vasc(searchfrom, 3),...
    'k+', 'MarkerSize', 4, 'LineWidth',4)
end
clear IN IDS ans c i j id seg
