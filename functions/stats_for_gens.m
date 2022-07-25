function [lens, arclens, stats] = stats_for_gens(g, vasc, seg,no_to_plot)
load rad.dat
    figure; 
    map = colormap('parula');
    color_step = floor(length(map)/no_to_plot);
    for i = 1:length(g)

        for j = 1:length(g{i})
            if i < no_to_plot
                subplot(2, 2, 1); 
                hold on; axis image; view(3)
                plot3(vasc(seg{g{i}(j)}, 1), vasc(seg{g{i}(j)}, 2), ...
                    vasc(seg{g{i}(j)}, 3), '-', 'color', map(color_step*(i-1)+1, :));
            end
            arclens{i}(j) =sum(arclength(vasc(seg{g{i}(j)}, :)));
            rads{i}(j, 1:3) =[min(rad(seg{g{i}(j)}, :)) mean(rad(seg{g{i}(j)}, :)) max(rad(seg{g{i}(j)}, :)) ];

            
            lens{i}(j) = length(seg{g{i}(j)});
%     pause
    end
    stats(i, :) = [mean(lens{i}), std(lens{i}) mean(arclens{i}), std(arclens{i}) length(arclens{i})];
    

    subplot(2, 2, 2); plot(i*ones(size(lens{i})), lens{i}, '-+'); hold on
    xlabel('Generation')
    ylabel('Element Count Distribution')
    subplot(2, 2, 3); plot(i*ones(size(arclens{i})), arclens{i}, '-+'); hold on
    xlabel('Generation')
    ylabel('Arc Length Distribution')
    
%     drawnow limitrate
% pause
end

[v, p]  = max(stats(:, 2))
[v, p]  = min(stats(2:end, 2))

end