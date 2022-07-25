load data/vasc.dat
% h = figure
close all
plot3(vasc(:, 1), vasc(:, 2), vasc(:, 3), 'k.', ...
    linewidth=1, markersize = 4)
view([40, 0])
axis image off
savefig('PaperFigs/fig1')
saveas(gcf, 'PaperFigs/fig1', 'png')
