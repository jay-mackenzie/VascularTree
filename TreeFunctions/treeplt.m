function treeplt(tree, map, vasc)
%     load vasc.dat    
    hold on; axis off equal; view(3)
    for i = 1:length(tree)
        plot3(vasc(tree{i}, 1), vasc(tree{i}, 2), vasc(tree{i}, 3), ...
            'LineWidth',3, 'Color',map(mod(i, length(map(:, 1)))+1, :))
    end
end