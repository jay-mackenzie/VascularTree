load seg.mat
load path.mat
load vasc.dat

close all
clear all
clc


trif(seg, path, vasc)
bif(seg, path, vasc)

function trif(seg, path, vasc)
tree = trifPaths(seg, sortGens(100 , seg, path{1}(1)));
trif_gens = sortGens(100, tree , path{1}(1));
trif_ords = find_ords(tree, trif_gens);
plt(trif_ords, vasc, trif_gens, tree);
end

function bif(seg, path, vasc)
bif_gens = sortGens(100, seg , path{1}(1));
bif_ords = find_ords(seg, bif_gens);
plt(bif_ords, vasc, bif_gens, seg);
end


function [unjoined, joined] = plt(ords, vasc, gens, seg)
for i = 1:max(ords)-1
    figure
    subplot(1, 2, 1)
    [unjoined{i}, joined{i}] = filter(ords, vasc, gens, seg, i);
    view(3)
    axis image off
    subplot(1, 2, 2)
    leg(ords, i)
    xlim([-2 -1])
    axis off
end
end

%% function to assign order to all vessels
function o = find_ords(s, g)
    o = zeroth_ord(s, g);

    for i = length(g)-1:-1:1
        for j = 1:length(g{i})
            if o(g{i}(j)) == -1
                fnl = s{g{i}(j)}(end);
                d_o = [];
                for k = 1:length(g{i+1})
                    if s{g{i+1}(k)}(1) == fnl
                        d_o = [d_o o(g{i+1}(k))];
                    end
                end

                if sum(max(d_o) == d_o) == 1
                    o(g{i}(j)) = max(d_o);
                else
                    o(g{i}(j)) = max(d_o)+1;
                end

            end
        end
    end
end

%% find segs of ord 1
function ords = zeroth_ord(s, g)
    ords= -ones(size(s));
    ords(g{length(g)}) = ones(size(g{length(g)}));

    for i = length(g)-1:-1:1
        for j = 1:length(g{i})
            fnl = s{g{i}(j)}(end);
            d = [];
            for k = 1:length(g{i+1})
                if s{g{i+1}(k)}(1) == fnl ;d = [d; k]; break; end
            end
        
            if isempty(d); ords(g{i}(j)) = 1; end
        end
    end
end

%% plot the tree with colour coded orders
function [unjoined, joined] = filter(ords, vasc, g, s, filter)
    if max(ords) > 7
        map = colormap("spring"); 
        no_colours_needed = max(ords)+1;
        map = map(floor(linspace(1, length(map), no_colours_needed)), :);
    else
        map = unique(colormap('lines'), 'rows');
    end

size(map)
    unjoined = [];
    for i = 1:length(g)
        for j = 1:length(g{i})
            if ords(g{i}(j)) >= filter
                plot3(vasc(s{g{i}(j)}, 1), vasc(s{g{i}(j)},2), ...
                    vasc(s{g{i}(j)},3), ...
                    'LineWidth',ords(g{i}(j)), ...
                    'Color',map(ords(g{i}(j)), :)); 
                hold on;
                unjoined{length(unjoined)+1} = s{g{i}(j)};
            end
        end
    end

    axis off image
    view(3)


    joined = seriesJoins(unjoined);

end

%% make a legend
function leg(ords, filter)

    
    if max(ords) > 7
        map = colormap("spring"); 
        no_colours_needed = max(ords)+1;
        map = map(floor(linspace(1, length(map), no_colours_needed)), :);
    else
        map = unique(colormap('lines'), 'rows');
    end
    l = {};

    if min(ords) > filter
        filter  =  min(ords);
    end


c = 1;
    for i = max(ords):-1:filter
        plot([0 1], [i i], '-', 'Color', map(i, :), 'LineWidth',i);
        hold on
        l{c}= sprintf("Order %i", i); c = c+1;
        xlim([-2 -1])
    end

    legend(l, "FontSize",15)
end
