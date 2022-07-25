for i = 1:length(keep)
    

    for j = i+1:length(keep)
        clc
        [rn, cn] = size(unique([keep{i}; keep{j}],'rows', 'stable'));
        [ri, ~]  = size(keep{i});
        [rj, ~]  = size(keep{j});

        if rn ~= ri+rj
        keep{i}
        keep{j}
        unique([keep{i}; keep{j}],'rows', 'stable')
        keep{j} = [];
        
        end

%         if size(keep{i}) ~= size(keep{j})% && keep{i} ~= keep{j}
%             keep{i}
% 
%             keep{j}
%         end
    end
end

count = 1;
for i = 1:length(keep)
    if ~isempty(keep{i})
        new_keep{count} = keep{i};
        count = count +1;
    end
end

keep = new_keep;
save keep