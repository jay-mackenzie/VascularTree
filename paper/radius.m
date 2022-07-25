clear all

load ./data/seg.mat
load ./data/xyz.mat
load ./data/t.mat
load ./data/rad.dat
load path.mat

nm = ["mean", "pct", "single"];

thresh = 0.6;
for i = 1:3; tree{i} = {}; tr{i} = tree{i}; end


for i = seg
    j = i{1};
    k = [mean(rad(j))>=thresh
    (sum(rad(j)>thresh)./length(rad(j)))>=.95
    sum(rad(j)>thresh)>0
    ]';

    
    for l = 1:3
        if k(l)
            tree{l}(length(tree{l})+1) = {j};
        end
    end
end


close all



for i = 1:3
    tr{i} = rmDisconn(tree{i}, path{1}(1));
    h(i) = figure;
    h(i).Position = [150+310*(i-1) 460 290 420];
    for j = tr{i}
        jj = j{1};

        plot(t(jj), xyz(jj, 3), 'k-', LineWidth=3); hold on
    end


    int{i} = [];
    for j = 1:length(tree{i})
        jj = tree{i}{j};
        for k = tr{i}
            if length(k{1}) == length(jj)
                if k{1} == jj
                    int{i} = [int{i} j];
                end
            end
        end
    end
%     tree{i}
    diconn{i} = setdiff(1:j, int{i});

    for j = diconn{i}
        jj = tree{i}{j};
        plot(t(jj), xyz(jj, 3), 'c-.', LineWidth=5); hold on

    end




    [length(tr{i}) length(tree{i})-length(tr{i})]
    ylim([0 100])
    axis off
    n(i) = sprintf("./PaperFigs/radius-%s", nm{i});
    savefig(n(i))
    n(i) = sprintf("%s.png", n(i));
    saveas(gcf, n(i), 'png');
%     break
    
end
