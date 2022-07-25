%% remove disconnects

function temp = rmDisconn(tree, inlet)
% load vasc.dat
% figure;
% for i = tree
%     if length(i{1})
%         plot3(vasc(i{1}, 1), vasc(i{1}, 2),vasc(i{1}, 3),'c', 'LineWidth', 3); hold on
%     end
% end

for xx = 1:100
    lst = [];
    for i = tree; if ~isempty(i{1}), lst = [lst; i{1}(1) i{1}(end)]; end; end
    % if inlet node not in list of outlets, disconn
    rm = setdiff(setdiff(lst(:, 1), lst(:, 2)), inlet);

    rmed = [];
    for i = 1:length(tree)
        if ~isempty(tree{i})
            if intersect(rm,tree{i}(1))
%             intersect(rm,tree{i}(1))
                tree{i} = []; rmed = [rmed; 1];
            end
        end
    end

    if isempty(rmed); break; end
end
clear temp
% count = 1; 

temp = rmEmpty(tree);

% plottree(temp, 'k')
% 
% axis off equal

end
