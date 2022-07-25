%% mouse network volume on a per generation basis

% i = 2;
% j = 2;
% XYZ = arcs{arc_index{i}(j)}(2:end, 1:3);
% sum(arclength(XYZ))
% if size(XYZ) == [2 3]; else; XYZ = XYZ(1:length(XYZ)-1:end, 1:3); end
% sum(arclength(XYZ))
%%
max_lrr = 0;
min_lrr = 10000;
clc

ii = 1; 
for i = 1:length(arc_index)
    for j = 1:length(arc_index{i})        
        XYZ = arcs{arc_index{i}(j)}(2:end, 1:3);
        a_len{i}(j) = sum(arclength(XYZ));
        if size(XYZ) == [2 3]; else; XYZ = XYZ(1:length(XYZ)-1:end, 1:3); end
        
        euclid{i}(j) = arclength(XYZ);

        rads{i}(j, 1:2) = mean(arcs{arc_index{i}(j)}(2:end, 4));%[min(arcs{arc_index{i}(j)}(2:end, 4)), ...
%             max(arcs{arc_index{i}(j)}(2:end, 4))];
        
        arc_lrr{i}(j) = mean(a_len{i}(j)./rads{i}(j, 1:2));
        euc_lrr{i}(j) = mean(euclid{i}(j)./rads{i}(j, 1:2));
        
        len_diff(ii) = a_len{i}(j) - euclid{i}(j); ii = ii +1;
        
        if euc_lrr{i}(j) > max_lrr;
            max_lrr = lrr{i}(j);
        end
        
        
        if euc_lrr{i}(j) < min_lrr;
            min_lrr = lrr{i}(j);
        end
        
        
        
        v{i}(j) = volume(arcs{arc_index{i}(j)}); % volume of each vessel in each gen
    end
end
%%
close all
map = colormap('parula');
map = map(end:-1:1, :);
hold on
bins = linspace(min_lrr, max_lrr, length(map));
% bins = logspace(log10(min_lrr), log10(max_lrr), length(map));

iii = 1;
for i = 1:length(arc_index)
    for j = 1:length(arc_index{i})
%        lrr{i}(j) 
       tmp = bins-lrr{i}(j);
       
       if lrr{i}(j) >= bins(end)
           bin_no(iii) = length(bins);
       else
        bin_no(iii)= find(tmp(1:end-1).*tmp(2:end) <= 0);
       end
       
       
       XYZ = arcs{arc_index{i}(j)}(2:end, 1:3);
        if size(XYZ) == [2 3]; else; XYZ = XYZ(1:length(XYZ)-1:end, 1:3); end

       X = XYZ(:, 1); Y = XYZ(:, 2); Z = XYZ(:, 3);
       plot3(X, Y, -Z, 'Color', map(bin_no(iii), 1:3))
       
       [i j];
       
       iii = iii + 1;
       
       
    end
end

axis image off
view(3)

%%
for i = 1:length(v); tot_vol(i) = sum(v{i}); end

for i = 1:length(arc_index); npg(i) = length(arc_index{i}); end

figure;
subplot(1, 3, 1)
plot(npg)
subplot(1, 3, 2)
plot(tot_vol)
subplot(1, 3, 3)
plot(tot_vol./npg)



function tv  = volume (tmp)
    XYZ = tmp(2:end, 1:3);
    tops = tmp(2:end-1, 4);
    bots = tmp(3:end, 4);
    lens = arclength(XYZ);
    v = (lens/3).*(tops+bots+sqrt(tops.*bots));
    tv = sum(v);
end



function d = arclength(xyz)
    [r, c] = size(xyz);
    if r >1
        for j = 1:r-1
            d(j, :) = sqrt(sum((xyz (j+1, :)-xyz(j, :)).^2));
        end
    else
        return
    end
    
    len = sum(sum(d));
end