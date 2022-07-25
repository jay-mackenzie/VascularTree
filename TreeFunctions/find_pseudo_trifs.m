clear
ld

clc

count = 0;

recorded = [0 0];
for i = 1:length(gens)
    for j = 1:length(gens{i})
        if length(seg{gens{i}(j)})<3
            if length(intersect(recorded, [i, j], 'rows')) == 0
                [i j]
                count = count+1;
                keep{count} = [i j]; % a short segment is detected
                keep{count} = [keep{count}; check(find_next(i, j))];
                recorded = [recorded; keep{count}];
            end
        end
    end
end

save keep

% run the script:
each_junc


function out = find_next(ii, jj)
ld
    out = [];
    for k = 1:length(gens{ii+1})
        if seg{gens{ii+1}(k)}(1) == seg{gens{ii}(jj)}(end)
            out = [out; ii + 1 k];
        end
    end
end

function out = check(in)
out = [];
ld;
    for k = in'
        if length(seg{gens{k(1)}(k(2))})<3
            out = [out; k'];
        end
    end
    
    if ~isempty(out)
        for k = out'
            out = [out; check(find_next(k(1), k(2)))];
        end
    end
end
