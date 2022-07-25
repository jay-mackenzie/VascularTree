run pure_radius.m
load vasc.dat
%% highlight disconn
close all
clear gens
gap = 0;

phi = -75;
phi = phi*pi/180;
R = [cos(phi) -sin(phi); sin(phi) cos(phi)];
for i = 4%2 :length(disconntree)
    figure(i)
    inc{i} = [];
    gens{i} = sortGens(100, disconntree{i}, path{1}(1))
    for j = 1:length(gens{i})
        for k = 1:length(gens{i}{j})
            
%             subplot(1,2, 1)
%             seg_plt(disconntree{i}{gens{i}{j}(k)}, 'k', 4)
            inc{i} = [inc{i} gens{i}{j}(k)];
%             subplot(1, 3, 2)
            [theta{i}{gens{i}{j}(k)},x{i}{gens{i}{j}(k)}, y{i}{gens{i}{j}(k)}] = mercatorProjection(vasc(disconntree{i}{gens{i}{j}(k)}, 1), vasc(disconntree{i}{gens{i}{j}(k)}, 2), gap);
            
            z{i}{gens{i}{j}(k)} = [vasc(disconntree{i}{gens{i}{j}(k)}, 3)];
%             plot(theta{i}{gens{i}{j}(k)}, z, ...
%                 'k', 'LineWidth',4); hold on
            
%             subplot(1, 2, 2)

            xy = [x{i}{gens{i}{j}(k)} y{i}{gens{i}{j}(k)}];

%                         plot3(xy(:, 1), xy(:, 2), z{i}{gens{i}{j}(k)}, 'k', 'LineWidth',4); hold on
            % roatate it
            for mm= 1:length(xy)
                xy(mm, :) = [R*xy(mm, :)']';
            end
            plot3(xy(:, 1), xy(:, 2), z{i}{gens{i}{j}(k)}, 'c', 'LineWidth',4); hold on
            view([0 ,0])
        end
    end
    


    for j = setdiff(1:length(disconntree{i}), sort(inc{i}, 'ascend'))
%         subplot(1, 2, 1)
%         seg_plt(disconntree{i}{j}, 'r', 3)
%         subplot(1, 2, 2)
        [theta{i}{j}, x{i}{j}, y{i}{j}] = mercatorProjection(vasc(disconntree{i}{j}, 1), vasc(disconntree{i}{j}, 2), gap);
%         plot(theta{i}{j}, vasc(disconntree{i}{j}, 3), ...
%                 'r', 'LineWidth',3); hold on
        z{i}{j} = vasc(disconntree{i}{j}, 3);
        plot3(x{i}{j}, y{i}{j}, z{i}{j}, 'r', 'linewidth', 3)
    end
%     subplot(1, 2, 1)
%     axis image off
%     view(2)
%     subplot(1, 2, 2)
    axis off
    
    
end

%%
clc
load path.mat
c = 1;
clear gens
if length(tree) < 7

map = colormap('lines');
map = unique(map, 'rows');
else
    map = colormap('parula');
    m = floor(linspace(1, length(map), length(tree)));
    map = map(m, :);
end



close all
figure
cc = 1;
load rad.dat
out = [];
for i = tree

    if ~isempty(i{1}) % if there are any vessels
        clc
        gens{c} = sortGens(100, i{1}, path{1}(1));
        if length(gens{c}) > 1 % if there are more than one gen
%             figure;
            
            for k = gens{c}
                for l = k{1}
                    tmp = tree{c}(l);
                    hold on
                    plot3(vasc(tmp{1}(1:length(tmp{1})-1:end), 1),vasc(tmp{1}(1:length(tmp{1})-1:end), 2),vasc(tmp{1}(1:length(tmp{1})-1:end), 3),...
                        '-', 'Color',map(cc, :),...
                        'LineWidth',3)
                    
                    
                    out = [out; mean(rad(tmp{1})) median(rad(tmp{1})) mean(rad(tmp{1}))-median(rad(tmp{1}))];

                end
            end
            cc = cc+1;
            axis image off; view(3); shg


        end
        
    end
    c = c+1;
end


%%
clc
clear l
for i = 1:length(tree)
    l{i} = [];
%     figure;

    for j = 1:length(gens{i})-1
        for k = 1:length(gens{i}{j})

                curr = tree{i}{gens{i}{j}(k)};

                tmp = [];
                for n = 1:length(gens{i}{j+1})
                    next = tree{i}{gens{i}{j+1}(n)};

                    tmp = [tmp curr(end) == next(1)];
                end
                
                if sum(tmp) == 0
%                     plotthree(vasc(curr, :), 'c-')
                    l{i} = [l{i}; i j k length(curr)];

                else

%                     plotthree(vasc(curr, :), 'm-')
                end
%                 view(3); axis image off
%                 
%                 drawnow; pause
                
        end


    end

    toRm{i} = l{i}(l{i}(:, 4) < (mean(l{i}(:, 4))-std(l{i}(:, 4))), 1:3);
%     toRm{i} = l(l(:, 4) < (mean(l(:, 4))-std(l(:, 4))), 1:3);

    [rs , cls] = size(toRm{i});

    for p = 1:rs
        toRm{i}(p, :)

        tree{toRm{i}(p, 1)}{gens{toRm{i}(p, 1)}{toRm{i}(p, 2)}(toRm{i}(p, 3))} = [];
    end
    

%     tree{12}{gens{12}{3}(3)}
%     break
    
    
%     for j = 1:length(tree{i})
%         l = [l length(tree{i}{j})];
%     
%     end
%     
%     for j = 1:length(tree{i})
%         if length(tree{i}{j}) <= mean(l)   
%             plotthree(vasc(tree{i}{j},:), 'c-')
%         else
%             plotthree(vasc(tree{i}{j},:), 'm-')
%         end
%     end
% %     break

end

%%



for i = 1:length(tree)
    for j = 1:length(tree{i})
        if isempty(tree{i}{j})
            [i j]
        end

    end
end