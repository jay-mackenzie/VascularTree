function lst = setminus(lst, to_rm) % removes an element from a vector
    for i = to_rm
        lst = lst(lst ~= i); 
    end
end