function [OverRadConn, OverRad] =better_filter_application(MinRad)

load seg.mat
load path.mat
load vasc.dat
load rad.dat
load edges.dat

[seg, inlet, bifNodes, endpaths, ~] = load_and_sort();%path, edges);

% make the tree trifurcating
seg = trifPaths(seg, sortGens(100 , seg, inlet));
gens = sortGens(100, seg , inlet);
% radius filter

% MinRad = mean(rad);
IDS = [];
for i = 1:length(seg)
    if mean(rad(seg{i})) >= MinRad % mean rad
%     if sum(rad(seg{i}) >=MinRad) > 0 % if a vessel contains a point of the required rad
        IDS = [IDS i];
    end
end
length(IDS)
%%
% figure; hold on 
for i = 1:length(IDS)
%     plotthree(vasc(seg{IDS(i)}, :), '-')
    OverRad{i} = seg{IDS(i)};
end


if length(IDS) > 1
% axis image off
% view(3)

OverRadGens = sortGens(100, OverRad, inlet);

c = 1;
for i = 1:length(OverRadGens)
    for j = 1:length(OverRadGens{i})
%         plotthree(vasc(OverRad{OverRadGens{i}(j)}, :), '-c')
        OverRadConn{c} = OverRad{OverRadGens{i}(j)}; c = c+1;
    end
end


OverRadConn = seriesJoins(OverRadConn);
OverRadGens = sortGens(100, OverRadConn, inlet);
size(OverRadConn);


for i = 1:length(OverRadGens)
    for j = 1:length(OverRadGens{i})
%         plotthree(vasc(OverRadConn{OverRadGens{i}(j)}, :), '-c')

        if length((OverRadConn{OverRadGens{i}(j)})) <= 2
%             plotthree(vasc(OverRadConn{OverRadGens{i}(j)}, :), '-m')
            
%             [i j]
            OverRadConn{OverRadGens{i}(j)} = [];
        end

    end
end
% axis image off
% view(3)
size(OverRadConn);
OverRadConn = rmEmpty(OverRadConn);size(OverRadConn);
OverRadConn = seriesJoins(OverRadConn);size(OverRadConn);
elseif isempty(IDS)
    OverRadConn = [];
else
    OverRadConn = OverRad;
end