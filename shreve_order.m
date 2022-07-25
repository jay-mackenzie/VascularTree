trif_ords = find_ords(tree, trif_gens);
bif_ords = find_ords(seg, gens);

for i = 0
    plt_tree(trif_ords, vasc, trif_gens, tree, mean(trif_ords))
    plt_tree(bif_ords, vasc, gens, seg, mean(bif_ords))

end



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
                    o(g{i}(j)) = sum(d_o);
            end
        end
    end
end

%%
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
function plt_tree(ords, vasc, g, s, filter)
    figure; hold on
    map = colormap("spring"); 
%     map = map(floor(linspace(1, length(map), max(ords)+1)), :);
    c = unique(ords);
    m1 = floor(linspace(1, length(map), length(unique(ords))));
    for i = 1:length(g)
        for j = 1:length(g{i})
            if ords(g{i}(j)) >= filter
%                 c == ords(g{i}(j))
%                 find(c == ords(g{i}(j)))

                m= map(m1(find(c == ords(g{i}(j)))), :);

                
%                 m = map(find((c(1:end-1)-ords(g{i}(j))).*(c(2:end)-ords(g{i}(j)))<=0), :);
%                 m = m(1, :);
                plot3(vasc(s{g{i}(j)}, 1), vasc(s{g{i}(j)},2), ...
                    vasc(s{g{i}(j)},3), ...
                    'Color',m, ...
                                    'LineWidth',3);
                
            end
        end
    end

    axis off image
    view(3)
end
