clear conntree disconntree  gen
load rad.dat
dr = 0.05*2;
% r = min(rad)+dr:dr:max(rad)-dr;
r = 0.2:0.1:0.9;
% % r = 0.3:0.05:0.9;
%%
for i = 1:length(r)    
    [conntree{i}, disconntree{i}] = better_filter_application(r(i));
    i
end
%%
clear tmp
c = 1;
for i = conntree
    if length(i{1}) > 1
        tmp{c} = i{1};
        c = c+1;
    end
end

clear conntree
conntree = tmp;
clear tmp

% load vasc.dat
% close all
% for i = tree
%     if ~isempty(i{1})
%         figure;
%         for j = i{1}
%             
%             plotthree(vasc(j{1}, :), '-'); hold on
%         end
%         axis image off
%         view(3)
%     end
% end