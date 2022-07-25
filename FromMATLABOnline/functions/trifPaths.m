function trifs = trifPaths(seg, gens)


for i = 1:length(gens)-1
    for j = 1:length(gens{i})
        if length(seg{gens{i}(j)}) == 2
            for k = 1:length(gens{i+1})
                if seg{gens{i}(j)}(end) == seg{gens{i+1}(k)}(1)
                    seg{gens{i+1}(k)} = [seg{gens{i}(j)}(1) seg{gens{i+1}(k)}(2:end)];
                end
            end
            seg{gens{i}(j)} = [];
        end
    end
end

count = 0;
for i = 1:length(seg); if length(seg{i}) ==0; count = count +1; end; end
for i = length(seg)-count; trifs{i} = []; end

count = 1;
for i = 1:length(seg)
    if length(seg{i}) ~=0; trifs{count} = seg{i}; count = count + 1; end
end
end
% map = colormap('lines'); f = figure; f.Position =[440 378 560*2 420];
% for i =1:length(trifgen)
%     for j = 1:length(trifgen{i})
%         
%         subplot(1, 2, 1); hold on; axis off
%         plotthree(vasc(trifs{trifgen{i}(j)}, :),'-', 3, map(i, :))
%         
%         subplot(1, 2, 2); hold on; axis off
%         plot(...
%         mercatorProjection(vasc(trifs{trifgen{i}(j)}, 1), ...
%         vasc(trifs{trifgen{i}(j)}, 2),4), ...
%         vasc(trifs{trifgen{i}(j)}, 3), 'LineWidth',3,'Color', map(i, :))
%         
%     end
%     i
% end
% 
% subplot(1, 2, 1); axis equal; title("$(x, y)$-plane", 'Interpreter', 'latex', 'FontSize', 20)
% plot3(vasc(bifNodes, 1),vasc(bifNodes, 2),vasc(bifNodes, 3), 'ok', 'MarkerSize', 7, 'LineWidth', 5);
% subplot(1, 2, 2); title("Mercator Projection", 'Interpreter', 'latex', 'FontSize', 20)