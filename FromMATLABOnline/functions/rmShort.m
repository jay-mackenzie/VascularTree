function temp = rmShort(tree)

terms = findterms_new(tree);

termslen = [];
for i = tree
    if intersect(i{1}(end), terms)
        termslen = [termslen length(i{1})];
    end
end

[q1, ~, q2, iqr] = median_Jay(termslen);

for i = 1:length(tree)
    if intersect(tree{i}(end), terms)
        if (length(tree{i})<q1)
            tree{i} = [];
        end
    end
end
temp = rmEmpty(tree);
end