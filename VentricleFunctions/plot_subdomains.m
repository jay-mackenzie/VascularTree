
function [k, vol] = plot_subdomains(pts, lst)

% figure
map = colormap('parula');
leg = [];

for i = 1:max(lst)
    m = map(floor(length(map)/max(lst))*(i-1)+1, :);
    hold on;
    [k{i}, vol(i)] = boundary(pts(find(lst == i), :), 1);
    trisurf(k{i}, ...
        pts(find(lst == i), 1), pts(find(lst == i), 2), pts(find(lst == i), 3),...
        'facecolor', m, 'facealpha', 0.75, 'edgecolor', m*0.9)
    leg = [leg; sprintf('sub %i', i)];
end
legend(leg)
vol = vol*(0.1^3); % conversion from cubic mm to ml
axis image off
view(3)
end