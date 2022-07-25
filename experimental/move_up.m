clear all; close all
marker = {'r', 'g', 'b', 'c', 'm', 'y', 'k'};
load seg.mat
load vasc.dat
load path.mat
for i = 1:length(path);if length(path{i}) ==1;i;break;end;end; inlet_pt = i;
gens = sortGens(100, seg, inlet_pt);

count = 0;
figure
for i = 1:3
    for j = 1:length(gens{i})
        plotthree(vasc(seg{gens{i}(j)}, :), marker{i}); hold on
    end
    count = count+length(gens{i});
end
axis image
one = [-4.3 -3]; two = [7.4 8.5];xlim(one); ylim(two);

%%
clc
close all
count = 0;
thresh = 2;
for i =length(gens):-1:1
    for j = 1:length(gens{i})
        if length(seg{gens{i}(j)}) == 2
            short = seg{gens{i}(j)};
            
            % if the short segment is terminal, don't do anything
            for k = 1:length(gens{i+1})
                if seg{gens{i+1}(k)}(1) == short(end)
%                    seg(gens{i+1}(k))



            figure
            count = count +1;
            subplot(1,3, 1); plt_seg(gens, i, j, 'm-'); hold on
            
            % find upstream
            for k = 1:length(gens{i-1})
                if seg{gens{i-1}(k)}(end) == short(1)
                    for kk = 1:2:3; subplot(1,3, kk); plt_seg(gens, i-1, k, 'c-'); end

                    subplot(1, 3, 2); hold on
                    plotthree(vasc([seg{gens{i-1}(k)}(1:end-1) seg{gens{i}(j)}(end)], :), 'c-');

                end
            end

            % find siblings
            for k = 1:length(gens{i})
                if seg{gens{i}(k)}(1) == short(1) && seg{gens{i}(k)}(end) ~= short(end)
                    for kk = 1:2:3; subplot(1,3, kk); plt_seg(gens, i, k, 'b-'); end
                    
                    subplot(1, 3, 2); hold on
                    plotthree(vasc([seg{gens{i}(j)}(end) seg{gens{i}(k)}(2:end)], :), 'b-'); 
                end
            end

            % find daughters
            for k = 1:length(gens{i+1})
                if seg{gens{i+1}(k)}(1) == short(end)
                    subplot(1,3, 1); plt_seg(gens, i+1, k, 'k-')
                    subplot(1,3, 2); plt_seg(gens, i+1, k, 'k-')
                    
                    subplot(1,3, 3); 
                    plotthree(vasc([seg{gens{i}(j)}(1) seg{gens{i+1}(k)}(2:end)], :), 'k-'); 

                end
            end
            

                            if count >= thresh; return; end
                            end
            end
        end
    end
end

view(2)
axis image
%%
j = 1;
figure;
for i = 1:length(seg)
    if length(seg{i}) == 0
        i
    else
        new_seg{j} = seg{i}; j = j+1;
        plotthree(vasc(seg{i}, :), 'k'); hold on
    end
end


%% function: plt_seg
function plt_seg(gens, i, j, marker)
load vasc.dat
load seg.mat
    plotthree(vasc(seg{gens{i}(j)}, :), marker)

%     plotthree(vasc(seg{gens{i}(j)}, :), '.k')

end