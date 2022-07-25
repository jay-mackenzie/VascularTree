function trifs = trifPaths(seg, gens)


for i = 1:length(gens)-1
    for j = 1:length(gens{i})
        if length(seg{gens{i}(j)}) == 2
            for k = 1:length(gens{i+1})
                if seg{gens{i}(j)}(end) == seg{gens{i+1}(k)}(1)
                    seg{gens{i+1}(k)} = [seg{gens{i}(j)}(1) seg{gens{i+1}(k)}(2:end)];
                end
            end
            seg{gens{i}(j)} = [];
        end
    end
end

count = 0;
for i = 1:length(seg); if length(seg{i}) ==0; count = count +1; end; end
for i = length(seg)-count; trifs{i} = []; end

count = 1;
for i = 1:length(seg)
    if length(seg{i}) ~=0; trifs{count} = seg{i}; count = count + 1; end
end
end