%% sortGens.m
% takes all segments in the tree, and sorts them into generations
%
% Parameters:
%  - maxGen: the maximum number of generations you're interested in. Capped
%            at 41 (for bifs), 31 (for trifs).
%  - seg: the cells containing the IDs that define each segment
%  - inlet node ID


function [gen] = sortGens(MaxGen, seg, inlet)
clear gen
% there are 42 generations total, but only 41 that give rise to new vessels

% make maxGen number of cells to fill 
for i = 1:MaxGen
    gen{i} = [];
end

% gen(1) = {1};
for i = 1:length(seg); if seg{i}(1) == inlet; gen(1) = {i}; break; end; end


% find the next generation
for k = 1:length(gen)
    temp = [];
    for j = 1:length(gen{k})
    	for i = 1:length(seg)
            if seg{i}(1) == seg{gen{k}(j)}(end)
                temp = [temp i];
            end
        end
    end
    gen(k+1) = {temp};
%     k
end

for i =1:length(gen); l(i) = length(gen{i}); end
found = find(l==0);
if length(found) ~= 0;
gen = gen(1:found-1);
end



