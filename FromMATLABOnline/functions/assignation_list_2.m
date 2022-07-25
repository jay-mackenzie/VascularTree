% take the nodes that are unassigned and find the elements in which each
% appears. Find the subdomain of each node in those elements. Assign the
% current node to the modal subdomain of the neighbouring nodes.

unassigned = find(lst == -1);
length(find(lst == -1))
for i = 1:length(unassigned)
    tmp = elts(mod(find(elts==unassigned(i)), length(elts)), :);
    [r, c] = size(tmp); 
        % for each of the elements
            tmp2 = [];
            for j = 1:r
                tmp2 = [tmp2 mode(lst(tmp(j, :), :))];
            end
            lst(unassigned(i)) = mode(tmp2(tmp2~=-1));                
end
length(find(lst == -1))