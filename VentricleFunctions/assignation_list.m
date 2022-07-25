
% cannot make into a function? can't take arguments that are cells

lst = -ones(size(ptsinhull{1}));
for i = 1:length(ptsinhull)
    lst(find(ptsinhull{i}==1)) = i;
end

clc
count_unassigned = [length(find(lst == -1))];
count_unassigned(1)

% consider the elements that contain an unassigned node. If all the other
% nodes in an element are assigned to the same subdomain, assign the
% current node to that subdomain. Otherwise, skip it.
% Stop when the number of unassigned nodes stops decreasing.
while find(lst == -1)
    run assign.m
    
    count_unassigned = [count_unassigned length(find(lst == -1))];
    count_unassigned(end)
    if count_unassigned(end) == count_unassigned(end-1)
        fprintf('\nstopped. there are unreachables\n')
        return
    end
    
end
% kind of slow: at worst is quadratic time.
% output you want: lst
