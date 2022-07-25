load rad.dat
clc
for i = 1:length(seg)
    mn(i) = min(rad(seg{i}));
    mx(i) = max(rad(seg{i}));
    md(i) = mean(rad(seg{i}));
    lngth(i) = al(vasc(seg{i}, :));
end

% al([2 0 0; 0 0 0])
lrr = lngth./md;
colour_tree(seg, vasc, lrr)
%% arclength finder
function len = al(xyz)
    [r, c] = size(xyz);
    if r >1

        for j = 1:r-1
            d(j) = sqrt(sum((xyz(j, :)- xyz(j+1, :)).^2));
%             d(j) = dist(xyz (j, :), xyz (j+1, :));
        end
    else
        return
    end
%     
    len = sum(d);
% len = 0
end

function colour_tree(seg, vasc, lrr)
figure; clf; hold on
map = colormap("spring");

% map = map(floor(linspace(1, length(map), max(ords)+1)), :);

for i = 1:length(seg)
%     if ords(i) > filter
    plot3(vasc(seg{i}, 1), vasc(seg{i}, 2), vasc(seg{i}, 3),...
        'Color',map(ceil(lrr(i)), :))
%     ords(i)
%     end
end
axis off image
view(3)
end
