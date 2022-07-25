function lst = findNaNs(lst)
pos = lst>0; b = find(~pos == 1); lst(b) = -1;
end