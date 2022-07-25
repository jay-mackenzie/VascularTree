for i = 1:length(lst)
        if lst(i) == -1 % if a node is not assigned to a subdomain
        
        % look up all the elements in which it appears
            tmp = elts(mod(find(elts==i), length(elts)), :);
        
        
            [r, c] = size(tmp); 
        % for each of the elements
            tmp2 = [];
            for j = 1:r
                tmp2 = [tmp2 mode(lst(tmp(j, :), :))];

            end
%             tmp2
            if length(unique(tmp2(find(tmp2~=-1)))) == 1
                lst(i) = unique(tmp2(find(tmp2~=-1)));
            end

        end
    end
    