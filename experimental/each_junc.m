

load keep
ld;
load vasc.dat
% clf
clc

wrong = [];
for i = 1:length(keep)
    [r, c] = size(keep{i});
    p = find_parent(keep{i}(1, 1), keep{i}(1, 2));
    s = [];
    for j = 1:r
        s = [s; find_sib(keep{i}(j, 1), keep{i}(j, 2)); ...
            find_daughter(keep{i}(j, 1), keep{i}(j, 2))];
    end
    for p = s'
        if sum(sum([keep{i}-p' == [0 0]]')' == 2) == 0
            if length(seg{gens{p(1)}(p(2))}) < 3
                wrong = [wrong; i];
            end
        end
    end
end

clc
load keep
load wrong

for i = 1:length(wrong)
    if ~isempty(keep{wrong(i)})
        this = seg{gens{keep{wrong(i)}(1, 1)}(keep{wrong(i)}(1, 2))}(1);
        for j = i+1:length(wrong)
            if ~isempty(keep{wrong(j)})
                if seg{gens{keep{wrong(j)}(1, 1)}(keep{wrong(j)}(1, 2))}(1) == this
                    keep{wrong(i)} = [keep{wrong(i)}; keep{wrong(j)}];            
                    keep{wrong(j)} = [];
                end
            end
        end
    end
end


save keep
count  = 1;

for i = 1:length(keep)

    if ~isempty(keep{i})
        new_keep{count} = keep{i};
        count = count +1;
    end
end
keep = new_keep;
save keep






%% functions:
function out = find_parent(ii, jj)
ld
    out = [];
    for k = 1:length(gens{ii-1})
        if seg{gens{ii-1}(k)}(end) == seg{gens{ii}(jj)}(1)
            out = [out; ii - 1 k];
        end
    end
end



function out = find_sib(ii, jj)
ld
    out = [];
    for k = 1:length(gens{ii})
        if seg{gens{ii}(k)}(1) == seg{gens{ii}(jj)}(1)
            if seg{gens{ii}(k)}(end) ~= seg{gens{ii}(jj)}(end)
                out = [out; ii k];
            end
        end
    end
end

function out = find_daughter(ii, jj)
ld
    out = [];
    for k = 1:length(gens{ii+1})
        if seg{gens{ii+1}(k)}(1) == seg{gens{ii}(jj)}(end)
                out = [out; ii+1 k];
        end
    end
end



