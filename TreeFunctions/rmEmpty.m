function temp = rmEmpty(tree)
    c = 1; 
    for i = tree;
        if ~isempty(i{1});
            temp{c} = i{1}; 
            c = c +1; 
        end;
    end
end