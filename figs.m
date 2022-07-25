load vasc.dat
close all
figure(1)
for i = 1:length(seg)
    
    plot3(vasc(seg{i}, 1),vasc(seg{i}, 2),vasc(seg{i}, 3), 'k-', 'MarkerSize',1); hold on
end

figure(2)
for i = 1:length(seg)
    plot3(vasc(seg{i}(1:length(seg{i})-1:end), 1),vasc(seg{i}(1:length(seg{i})-1:end), 2),vasc(seg{i}(1:length(seg{i})-1:end), 3), 'k-', 'MarkerSize',1); hold on
end
                        
plot3(vasc(inlet_pt, 1), vasc(inlet_pt, 2),vasc(inlet_pt, 3), 'co', 'markersize', 8, 'LineWidth',5)

for i = 1:2
    figure(i); view(3);axis off image
end






for i = 1:length(path);if length(path{i}) ==1;i;break;end;end; inlet_pt = i
for i= 1:length(seg);if seg{i}(1) == inlet_pt;break;end;end; inlet_seg = i


