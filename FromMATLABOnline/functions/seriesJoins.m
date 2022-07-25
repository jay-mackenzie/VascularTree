function tree = seriesJoins(tree)

for xx = 1:100
    len = length(tree);
    
    lst = []; for i = tree; lst = [lst; i{1}(1) i{1}(end)]; end
    tab = tabulate([lst(:, 1); lst(:, 2)]);
    findtwos = tab(find(tab(:, 2) == 2),1);

    join = [];
    for i = 1:length(tree)
        if intersect(tree{i}(end), findtwos)
            join = [join i];
        elseif intersect(tree{i}(1), findtwos)
            join = [join i];
        end
    end

    jointree = tree(join);

    for i = 1:length(jointree)
        for j = 1:length(jointree)
            if jointree{i}(end) == jointree{j}(1)
                tree{join(i)} = [tree{join(i)}(1:end-1) tree{join(j)}];
                tree{join(j)} =[];
            end
        end
    end

    tree = rmEmpty(tree);
    
    if length(tree) == len
        break
    end
end