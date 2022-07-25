%% paper figures

%% load data
addpath ./functions/
addpath('.\FromMATLABOnline')
load vasc.dat
load vasc.dat
load edges.dat
load path.mat
load rad.dat
[seg, inlet, bifNodes, endpaths, endNodes, newedges] = load_and_sort(path, edges);
a = [-3.7143 7.8671];
d = 1;
%%


% plt_nodes(vasc)
% plt_path(9104, vasc, path)
% pth_splith(9104, vasc, path, edges)
% seg_len()
% bif_vs_trif(seg, inlet, a, vasc)
% close all
% [bifseg, bifgen] = plt_gen(seg, inlet, vasc);
[trifseg, trifgen] = plt_gen(trifPaths(seg, sortGens(100, seg, inlet)), inlet, vasc);
% bif_vol = per_gen(bifgen, bifseg, vasc, rad)
% [trif_vol, trif_count] = per_gen(trifgen, trifseg, vasc, rad)
% [biflens, bifarcs, bifstats] = stats_for_gens(bifgen, vasc, bifseg);
% [triflens, trifarcs, trifstats] = stats_for_gens(trifgen, vasc, trifseg);


% radius_based_filtration(trifgen, trifseg, vasc, rad, 0.5, 0.75)
%%

function [lens, arclens, stats] = stats_for_gens(g, vasc, seg)

    figure; 
    map = colormap('parula');
    no_to_plot = 10;
    color_step = floor(length(map)/no_to_plot);
    for i = 1:length(g)

        for j = 1:length(g{i})
            if i < no_to_plot
                subplot(1, 3, 1); 
                hold on; axis equal; view(3)
                plot3(vasc(seg{g{i}(j)}, 1), vasc(seg{g{i}(j)}, 2), ...
                    vasc(seg{g{i}(j)}, 3), '-', 'color', map(color_step*(i-1)+1, :));
            end
            arclens{i}(j) =sum(arclength(vasc(seg{g{i}(j)}, :)));
            lens{i}(j) = length(seg{g{i}(j)});
%     pause
    end
    stats(i, :) = [mean(lens{i}), std(lens{i}) mean(arclens{i}), std(arclens{i}) length(arclens{i})];
    

    subplot(1, 3, 2); plot(i*ones(size(lens{i})), lens{i}, '-+'); hold on
    xlabel('Generation')
    ylabel('Element Count Distribution')
    subplot(1, 3, 3); plot(i*ones(size(arclens{i})), arclens{i}, '-.'); hold on
    xlabel('Generation')
    ylabel('Arc Length Distribution')
    
%     drawnow limitrate
% pause
end

[v, p]  = max(stats(:, 2))
[v, p]  = min(stats(2:end, 2))

end


function bif_vs_trif(seg, inlet, a, vasc)

[bifseg, bifgen] = plt_gen(seg, inlet, vasc); name = "topDownBif";
savefig(name); go = 'C:\Users\jmk119s\OneDrive - University of Glasgow\working papers\Vascular Paper\'; saveas(gcf, [go+name], 'png')

[bifseg, bifgen] = plt_gen(seg, inlet, vasc);xlim([a(1)-1, a(1)+1]); ylim([a(2)-1, a(2)+1]);
 name = "topDownBifZoom";
savefig(name); go = 'C:\Users\jmk119s\OneDrive - University of Glasgow\working papers\Vascular Paper\'; saveas(gcf, [go+name], 'png')

[trifseg, trifgen] = plt_gen(trifPaths(seg, sortGens(6, seg, inlet)), inlet, vasc);
 name = "topDownTrif";
savefig(name); go = 'C:\Users\jmk119s\OneDrive - University of Glasgow\working papers\Vascular Paper\'; saveas(gcf, [go+name], 'png')


[trifseg, trifgen] = plt_gen(trifPaths(seg, sortGens(6, seg, inlet)), inlet, vasc);xlim([a(1)-1, a(1)+1]); ylim([a(2)-1, a(2)+1]);
name = "topDownTrifZoom";
savefig(name); go = 'C:\Users\jmk119s\OneDrive - University of Glasgow\working papers\Vascular Paper\'; saveas(gcf, [go+name], 'png')

end

function seg_len()
load seg.mat
for i = 1:length(seg)
    l(i) = length(seg{i});
end
min(l)
max(l)
sum(l == min(l))
end



function pth_splith(i, vasc, path, edges)
    [seg, inlet, bifNodes, endpaths, ~] = load_and_sort(path, edges);
    figure;
    plot3(vasc(:, 1), vasc(:, 2), vasc(:, 3), 'k.', 'MarkerSize', 2); hold on
    
    
    [lst, ia, ib] = intersect(path{i}, bifNodes);
    ia = sort([1; ia]);
    plot3(vasc(lst, 1), vasc(lst, 2), vasc(lst, 3), ...
        'ro', 'MarkerSize', 5, 'LineWidth', 4); hold on
    
    marker = ['-'];
    for j = 1:length(ia)-1
        plot3(vasc(path{i}([ia(j):ia(j+1)]), 1), ...
            vasc(path{i}([ia(j):ia(j+1)]), 2),...
            vasc(path{i}([ia(j):ia(j+1)]), 3), ...
            'c-.', 'LineWidth', 4)
    end
    
    basis
    h = legend('Vascular nodes', 'Junction nodes', 'Segments');
    h.Position = [0.3984 0.8786 0.2393 0.0869];
    name = 'split';
    savefig([name '.fig'])
    go = 'C:\Users\jmk119s\OneDrive - University of Glasgow\working papers\Vascular Paper\';
    saveas(gcf, [go name], 'png')
end

function plt_path(i, vasc, path)
figure;
    plot3(vasc(:, 1), vasc(:, 2), vasc(:, 3), 'k.', 'MarkerSize', 2); hold on
    plot3(vasc(path{i}, 1),...
        vasc(path{i}, 2),...
        vasc(path{i}, 3),...
        '-c', 'linewidth', 4)
    basis
    h = legend('Vascular nodes', 'Sample Path');
    h.Position = [0.3984 0.8786 0.2393 0.0869];
    savefig('path.fig')
    go = 'C:\Users\jmk119s\OneDrive - University of Glasgow\working papers\Vascular Paper\';
    saveas(gcf, [go 'path'], 'png')

end


function plt_nodes(vasc)
    figure;plotthree(vasc, 'k.');
    basis
    savefig('pts.fig');
end


function [cumulative_vol, no_per_gen]=    per_gen(GEN, SEG, vasc, rad)


for i = 1:length(GEN)
    vol{i} = [];
    for j = 1:length(GEN{i})
        rs = rad(SEG{GEN{i}(j)});
        as = arclength(vasc(SEG{GEN{i}(j)}, :));
        vol{i}(j) = sum(seg_vol(rs, as));
    end
%     mean_vol(i) = sum(vol{i})/length(vol{i});
    no_per_gen(i) = length(GEN{i});
    cumulative_vol(i) = sum(vol{i});
end


h = figure;
subplot(1, 3, 1);
plot(no_per_gen); xlabel('Generation Number', ...
    'Interpreter', 'latex', 'fontsize', 15);
ylabel('Number of Vessels', ...
    'Interpreter', 'latex', 'fontsize', 15);
title({'Segment Count', 'Per Generation'}, ...
    'Interpreter', 'latex', 'fontsize', 15);
xlim([1 length(GEN)])


subplot(1, 3, 2);plot(cumulative_vol); 
xlabel('Generation Number', ...
    'Interpreter', 'latex', 'fontsize', 15);
title({'Total Segment Volume', 'Per Generation'}, 'Interpreter', 'latex', 'fontsize', 15);
ylabel('Volume, mm$^3$', 'Interpreter', 'latex', 'fontsize', 15);
xlim([1 length(GEN)])
subplot(1, 3, 3);plot(cumulative_vol./no_per_gen); 
xlabel('Generation Number', 'Interpreter', 'latex', 'fontsize', 15);
title({'Mean Segment Volume', 'Per Generation'}, 'Interpreter', 'latex', 'fontsize', 15);ylabel('Volume, mm$^3$', 'Interpreter', 'latex', 'fontsize', 15);
ylabel('Volume, mm$^3$', 'Interpreter', 'latex', 'fontsize', 15);

xlim([1 length(GEN)])
h.Position =[2350 494 878 247];

end