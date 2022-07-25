% X = showfrom;
X = searchfrom;
load seg.mat

for i = 1:length(path)
    [~, ~, j] = intersect(path{i}, X);
    if j
        downstream(i) = j;
    else
        downstream(i) = -1;
    end
end

%% tree volumes
% find all the segments that lie downstream of the insertion point
% find the volume of each segment


for j = 1:8
    figure(j);hold on
    treevol(j) = 0;
    segs{j} = [];
    for i = 1:length(seg)
        [in, ia, ib] = intersect(seg{i}, find(downstream == j));
        if in
            segs{j} = [segs{j}; i];
            plotthree(vasc(seg{i}, :), '-'); hold on
            for kk = 1:length(seg{i})-1
                tmp = [vasc(seg{i}(kk), :); vasc(seg{i}(kk+1), :)];
                d = sqrt(sum((tmp(1, :)-tmp(2, :)).^2));
                treevol(j) = treevol(j) + frusta_vol(rad(seg{i}(kk)), rad(seg{i}(kk+1)), d);
            end
        end
    end
    treevol(j)
end


[~, i] = sort(treevol);
figure; plot(treevol(i), v(i))

%% local functions
function vol = frusta_vol(r, R, d) % find the volume of conic sections
    vol = (pi*d/3)*(R^2 + r*R + r^2);
end