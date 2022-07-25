load MeshmixerToGeoBoxNodes.dat
addpath ./functions
nodes = MeshmixerToGeoBoxNodes; clear MeshmixerToGeoBoxNodes;

for i = 1:2
    nodes(:, i)= nodes(:, i) - (min(nodes(:, i))+max(nodes(:, i)))/2;
end


% clf; plotthree(nodes, '.'); axis equal; view(3)
%% boundaries
bdry = boundary(nodes, 1);
bdryind = [];
for i = 1:3; bdryind = [bdryind; bdry(:, i)]; end
bdryind = unique(bdryind);
bdrypts = nodes(bdryind, :);
% clf; plotthree(nodes(bdryind, :), '.'); axis equal; view(3)

%% Find Top Of Apex

lower = bdrypts(:, 3)>5;
upper = bdrypts(:, 3)<15;
between = bdrypts((find((lower+upper == 2))), :);

% clf; plotthree(between, '.'); axis equal; view(3)

tri = boundary(between, 0);

outer = [];
for i = 1:3; outer = [outer; tri(:, i)]; end
outer = unique(outer);

% clf; plotthree(between(outer, :), '.'); axis equal; view(3)

inner = setdiff(1:length(between),outer);

% plotthree(between(inner, :), '.'); axis equal; view(3)

[topOfApexP, topOfApexV] = min(between(inner, 3));

%% Divide ventricle between base and apex into three layers

[topOfBaseP, topOfBaseV] = max(nodes(:, 3));

divisions = linspace(topOfBaseP, topOfApexP, 4);

for i = 1:length(divisions)-1
    tp{i} = find(nodes(:, 3) <= divisions(i));
    bttm{i} = find(nodes(:, 3) >= divisions(i+1));
    layer{i} = intersect(tp{i}, bttm{i});

%     figure(i); plotthree(nodes(layer{i}, :), '.');
    xlim([-40 40]); ylim([-50 50]); zlim([0 60]); axis equal;view(3)
end
i = length(divisions);
layer{i} = find(nodes(:, 3) <= topOfApexP);
% figure(i); plotthree(nodes(layer{i}, :), ".");
% xlim([-40 40]); ylim([-50 50]); zlim([0 60]); axis equal;view(3)
%% sextants
count = 1;

for j = 1:2
    
    theta = linspace(0, 2*pi, 7);
    tmp = [theta(2:end), 2*pi+pi/3]; clear theta; theta = tmp; clear tmp
    r = max(abs([max(abs(nodes(:, 1))) max(abs(nodes(:, 2)))]))*2;
    A = r*cos(theta);
    B = r*sin(theta);
    
    tmp = nodes(layer{j}, :);

    for i = 1:length(theta)-1
        div{i} = [0 0; A(i) B(i); A(i+1), B(i+1); 0 0];
        ptch{i} = patch(div{i}(:, 1), div{i}(:, 2), i);

        in{i} = inpolygon(tmp(:, 1), tmp(:, 2), ...
            ptch{i}.Vertices(:, 1), ptch{i}.Vertices(:, 2));
    
        
        
        AHAregion{count} = tmp(find(in{i}==1), :); 

%         plotthree(tmp(AHAregion{count}, :), '.'); hold on

        count = count+1;
        
    end

end


%% quarters

for j = 3
    theta = linspace(0, 2*pi, 5);
    tmp = [theta(2:end), 2*pi+pi/2]; clear theta; theta = tmp; clear tmp
    r = max(abs([max(abs(nodes(:, 1))) max(abs(nodes(:, 2)))]))*2;
    A = r*cos(theta);
    B = r*sin(theta);
    tmp = nodes(layer{j}, :);
    for i = 1:length(theta)-1
        div{i} = [0 0; A(i) B(i); A(i+1), B(i+1); 0 0];
        ptch{i} = patch(div{i}(:, 1), div{i}(:, 2), i);
        in{i} = inpolygon(tmp(:, 1), tmp(:, 2), ...
            ptch{i}.Vertices(:, 1), ptch{i}.Vertices(:, 2));
        AHAregion{count} = tmp(find(in{i}==1), :);
        count = count+1;
        
    end
end

AHAregion{count} = nodes(layer{end}, :);

%% plot the AHA regions
figure; hold on; map = colormap('parula');
m = map(floor(linspace(1, length(map), length(AHAregion))), :);

for i = 1:length(AHAregion)
    AHAbdry{i} = boundary(AHAregion{i}, 1);
    trisurf(AHAbdry{i}, AHAregion{i}(:, 1),AHAregion{i}(:, 2),AHAregion{i}(:, 3),...
        'facecolor', m(i, :), 'edgecolor', m(i, :)*0.8);
    l(i) = string(sprintf('region %i', i));
end
axis equal; view(3)
legend(l)

%% plot the subdomains
figure; hold on

m = map(floor(linspace(1, length(map), max(unique(lst)))), :);
clear l
for j = 1:max(unique(lst))
        subbdry{j} = boundary(pts(find(lst == j), 1), ...
            pts(find(lst == j), 2),...
            pts(find(lst == j), 3), 1);

        trisurf(subbdry{j}, pts(find(lst == j), 1), ...
            pts(find(lst == j), 2),...
            pts(find(lst == j), 3),...
             'facecolor', m(j, :), 'edgecolor', m(j, :)*0.8);
         
             l(j) = string(sprintf('subdomain %i', j));

end
axis equal; view(3); legend(l)

%% Compare the regions and subdomains
for i = 1:length(AHAregion)
    for j = 1:max(unique(lst))
        invent = inpolyhedron(subbdry{j},pts(find(lst == j), :), AHAregion{i});
        sums(i, j) = sum(invent);
    end
end

%% Decide the region/subdomain map and put it in p.
count = 1;
for i = sums'
    [v, p(count)] = max(i);
    [count p(count)];
    count = count + 1;
end

%% clump the regions as per the previous comparison

for i = unique(p)
    joined{i} = [];
end

for i = 1:length(p)
    joined{p(i)} = [joined{p(i)}; AHAregion{i}];
end

%% plot the clumped regions
figure; 
map = colormap('parula');
m = map(floor(linspace(1, length(map),length(unique(p)))), :);

clear l
for i = unique(p)
    jtri{i} = boundary(joined{i}, 1);
    trisurf(jtri{i}, joined{i}(:, 1), joined{i}(:, 2), joined{i}(:, 3),...
        'facecolor', m(i-1, :), 'edgecolor', m(i-1, :)*0.8);
    hold on
                 l(i-1) = string(sprintf('subdomain %i', i));

end
legend(l)