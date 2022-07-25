function terms = findterms(tree)
    lst = []; for i = tree; lst = [lst; i{1}(1) i{1}(end)]; end
    terms = setdiff(lst(:, 2), lst(:, 1));
end