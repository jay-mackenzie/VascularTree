rad_ratio = 0:0.05:1;
strict = 0:0.05:1;
gens = 1:40;

for i = 1:length(rad_ratio)
    for j = 1:length(strict)
        for k = 1:length(gens)
            [tree, ~, ~] = makeTree(rad_ratio(i),strict(j),gens(k),0, rad, vasc, edges, path);
            A(i, j, k) = length(tree);
            length(tree)
        end
    end
end
