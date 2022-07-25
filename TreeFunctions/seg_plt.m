function seg_plt(lst, c, w)

load vasc.dat

plot3(vasc(lst, 1), vasc(lst, 2), vasc(lst, 3), ...
    'Color',c, 'LineWidth',w); hold on
end