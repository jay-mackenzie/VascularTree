path = struct2cell(load("path.mat")); path = path{1};


clear hull
for i = 1:length(searchfrom)+1
    hull{i} = [];
end

% unreachable = [];
for i = 1:length(path)
    if intersect(path{i},searchfrom)
        a = find(intersect(path{i},searchfrom) == searchfrom);
        hull{a} = [hull{a}; i];
    else
        hull{end} = [hull{end}; i];
    end
end
%%
close all;
for i = 1:length(searchfrom)
    k{i} = boundary(vasc(hull{i}, :), 1);
%     figure;
    plotthree(vasc(hull{i}, :), 'k.'); hold on
    
    % make shells around each perfused subtree
    trisurf(k{i}, vasc(hull{i}, 1), vasc(hull{i}, 2), vasc(hull{i}, 3),...
        'facealpha', 0.0) 
    
    % which nodes in the ventricle lie in each of the vascular hulls
    ptsinhull{i} = inpolyhedron(k{i}, vasc(hull{i}, :), pts);
    
    plotthree(pts(ptsinhull{i}, :), '.')
    
end
ptsinhull{i+1} = inpolyhedron(boundary(sc, 0.5), sc, pts);

% i = i+1; plotthree(vasc(hull{i}, :), 'r.')

a = zeros(size(ptsinhull{1}));

for i = 1:length(ptsinhull); a = a + ptsinhull{i}; end
for i = 1:length(ptsinhull); ptsinhull{i}(find(a>1)) = 0; end
a = zeros(size(ptsinhull{1}));
for i = 1:length(ptsinhull); a = a + ptsinhull{i};end
% to_assign = pts(find(a==0), :);

% useful: ptsinhull

