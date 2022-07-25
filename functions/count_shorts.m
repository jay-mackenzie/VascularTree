function c = count_shorts(bifgen, bifseg, bifNodes)
c=0;
for i =1:length(bifgen)-1
    for j = 1:length(bifgen{i})
        if intersect(bifseg{bifgen{i}(j)}, bifNodes)
            
            if length(bifseg{bifgen{i}(j)}) == 2
                c = c+1;
            end
        end
    end
end

