count = 0;
load seg
load gens
close all


% [7 42] doesn't work


for i = 1:length(gens)
    for j = 1:length(gens{i})
        if length(seg{gens{i}(j)}) == 2
%             h = figure;
%             hold on

            g = 1;
            [p{g}, s{g}, d{g}, l{g}] = if_short(i, j);
%             vis_junc(i, j, p{g}, s{g}, d{g})
            
            [g, p, s, d, l] = check_daughters(i, j, g, p, s, d, l)
            
%             name = sprintf('./junc_pics/junc_%i_%i.fig', i, j);
%             savefig(h, name);
%             close all
        end
    end
end

axis image
%%
function [daughters, lens] = find_daughters(ii, jj)
    load gens
    load seg
    daughters = [];
    lens = [];
    for k = 1:length(gens{ii+1})
        if seg{gens{ii+1}(k)}(1) == seg{gens{ii}(jj)}(end)
            daughters = [daughters k];
            lens = [lens length(seg{gens{ii+1}(k)})];
        end
    end
end

function [gg, pp, ss, dd, ll] = check_daughters(ii, jj, gg, pp, ss, dd, ll)
load seg
load gens
sprintf('check_daughters')
    for k = 1:length(dd{gg})
        if length(seg{gens{ii+1}(dd{gg}(k))}) == 2
            gg = gg+1;
            [pp{gg}, ss{gg}, dd{gg}, ll{gg}] = if_short(ii+1, dd{gg-1}(k));
%             vis_junc(ii+1, dd{gg-1}(k), pp{gg}, ss{gg}, dd{gg})

%             [gg, pp, ss, dd, ll] = check_daughters(ii+1, dd{gg}(k), gg, pp, ss, dd, ll)
        end
    end
end

function [parent, siblings, daughters, lens] = if_short(ii, jj)
%     short = seg{gens{ii}(jj)};
    parent = find_parent(ii, jj);
    siblings = find_siblings(ii, jj);
    [daughters, lens] = find_daughters(ii, jj);
end

function vis_junc(iii, jjj, parent, siblings, daughters)
            hold on 
            plt_seg(iii, jjj) % short vessel
            plt_seg(iii-1, parent) % parent vessel
            for k = 1:length(siblings); plt_seg(iii, siblings(k)); end; % siblings
            for k = 1:length(daughters); plt_seg(iii+1, daughters(k)); end; % daughters
            axis image

end





function j = find_parent(ii, jj)
load seg
load gens
    for j = 1:length(gens{ii-1})
        if seg{gens{ii-1}(j)}(end) == seg{gens{ii}(jj)}(1)
            return
        end
    end

end

function sibs = find_siblings(ii, jj)
load seg
load gens
sibs = [];
    for j = 1:length(gens{ii})
        if seg{gens{ii}(j)}(1) == seg{gens{ii}(jj)}(1) && seg{gens{ii}(j)}(end) ~= seg{gens{ii}(jj)}(end)
            sibs = [sibs j];
        end
    end
end

function plt_seg(ii, jj)
    load vasc.dat
    load seg
    load gens
    % seg{gens{ii}(jj)}
    if length(seg{gens{ii}(jj)}) < 3
        plotthree(vasc(seg{gens{ii}(jj)}, :), 'r-');
    else
        plotthree(vasc(seg{gens{ii}(jj)}, :), 'k-');    
    end
end