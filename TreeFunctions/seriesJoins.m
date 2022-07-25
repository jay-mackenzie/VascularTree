function tree = seriesJoins(tree)
path = load('path.mat');
path = path.path;
inlet = path{1}(1);
filtered_gens = sortGens(100, tree, inlet);




for i = 1:length(filtered_gens)-1
    for j = 1:length(filtered_gens{i})

        trm = tree{filtered_gens{i}(j)};
        count = 0;
        d = [];

        for k = 1:length(filtered_gens{i+1})
            strt = tree{filtered_gens{i+1}(k)};
            if trm(end) == strt(1)
                count = count +1;
                d = [d; i+1 k];
            end
        end
        
        
        if count == 1
            tree{filtered_gens{d(1)}(d(2))} = [trm tree{filtered_gens{d(1)}(d(2))}(2:end)];
            tree{filtered_gens{i}(j)} = [];
        end

    end
end



tree = rmEmpty(tree);

% for xx = 1:100
%     len = length(tree);
%     
%     lst = []; for i = tree; lst = [lst; i{1}(1) i{1}(end)]; end
%     tab = tabulate([lst(:, 1); lst(:, 2)]);
%     findtwos = tab(find(tab(:, 2) == 2),1);
% 
%     join = [];
%     for i = 1:length(tree)
%         if intersect(tree{i}(end), findtwos)
%             join = [join i];
%         elseif intersect(tree{i}(1), findtwos)
%             join = [join i];
%         end
%     end
% 
%     jointree = tree(join);
% 
%     for i = 1:length(jointree)
%         for j = 1:length(jointree)
%             if jointree{i}(end) == jointree{j}(1)
%                 tree{join(i)} = [tree{join(i)}(1:end-1) tree{join(j)}];
%                 tree{join(j)} =[];
%             end
%         end
%     end
% 
%     tree = rmEmpty(tree);
%     
%     if length(tree) == len
%         break
%     end
