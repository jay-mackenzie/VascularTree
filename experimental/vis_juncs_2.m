clc
clear all; ld;
for i = 7%:length(gens)
    for j = 12%:length(gens{i})
        if length(seg{gens{i}(j)})<3;
            clf
            s = find_sibs(i, j);
            to_plt = [find_parent(i, j); s];

            d{1} = [];
            for k = s'; d{1} = [d{1}; find_daughters(k(1),k(2))]; end
            

            d{2} = [];
            for k = d{1}';
                
                
                if length(seg{gens{k(1)}(k(2))})<3;
                    k'
                    d{2}  = [d{2}; find_daughters(k(1),k(2))];
                end
            
            
            end
%             to_plt

            plt(to_plt)

        end
    end
end





function s = find_sibs(ii, jj)
ld;
s = [ii, jj];
    for k = 1:length(gens{ii})
        if seg{gens{ii}(jj)}(1) == seg{gens{ii}(k)}(1)
            if seg{gens{ii}(jj)}(end) ~= seg{gens{ii}(k)}(end)
                s = [s; ii k];
            end
        end
    end
end

function out = find_daughters(ii, jj)
ld;
out = [];
    for k = 1:length(gens{ii+1})
        if seg{gens{ii+1}(k)}(1) == seg{gens{ii}(jj)}(end)
            out = [out; ii+1, k];
        end
    end
end


function plt(in)
ld;
load vasc.dat
for k = in'
    plotthree(vasc(seg{gens{k(1)}(k(2))}, :), '-'); hold on
end
end