close all
clear all
clc

load data/vasc.dat
load xyz.mat
load t.mat
load seg.mat
% vasc = xyz;
close all; figure

%%
for i = seg
    plot3(vasc(i{1}, 1), vasc(i{1}, 2), vasc(i{1}, 3) ...
        , LineWidth=2)
    if i{1}(1, 1) == path{1}(1)
        plot3(vasc(i{1}(1), 1), vasc(i{1}(1), 2), vasc(i{1}(1), 3), ...
            '+', ...
        LineWidth=5, MarkerSize= 10)
    end

    hold on
%     break
end

axis image off
view([40 0])
saveas(gcf, './PaperFigs/segs-norm', 'png')
savefig('./PaperFigs/segs-norm')
%%


close all; figure

for i = seg
    plot3(vasc(i{1}(1:length(i{1})-1:end), 1), ...
        vasc(i{1}(1:length(i{1})-1:end), 2), ...
        vasc(i{1}(1:length(i{1})-1:end), 3) ...
        , LineWidth=2)
    hold on
%     break
end

axis image off
view([40 0])

saveas(gcf, './PaperFigs/segs-ends', 'png')
savefig('./PaperFigs/segs-ends')

close all; figure
for i = seg
    plot(-t(i{1}), xyz(i{1}, 3), LineWidth=2)
    hold on
%     break
end
axis off
% axis image off
% view([40 0])
saveas(gcf, './PaperFigs/segs-merc', 'png')
savefig('./PaperFigs/segs-merc')