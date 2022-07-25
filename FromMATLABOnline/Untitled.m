load vasc.dat
load myoX.dat
load myoY.dat
load myoZ.dat
load MeshmixerToGeoBoxNodes.dat
load seg.mat
load path.mat


% myo = [myoX,myoY,myoZ]; clear myoX myoY myoZ;
myo = MeshmixerToGeoBoxNodes;

[~, p] = min(myo(:, 3));
xshift = myo(p, 1); yshift = myo(p, 2); zshift = myo(p, 3);
myo(:, 1) = myo(:, 1)- xshift; myo(:, 2) = myo(:, 2)- yshift;
myo(:, 3) = myo(:, 3)- zshift;

for i = 1:length(path); if length(path{i}) == 1; inlet = i; break; end; end

clf
myoBdry = boundary(myo(:, 1), myo(:, 2),myo(:, 3),1);
trisurf(myoBdry, myo(:, 1), myo(:, 2),myo(:, 3), ...
    'edgealpha' ,0, 'facealpha', 0.5); axis equal
hold on

out = ~inpolyhedron(myoBdry, myo, vasc);
out = find(out == 1); % the indicies of points out with the wall

% plotthree(vasc(out, :),'.')
% hold off


outSegs = [];

for i = 1:length(seg)
    
    if intersect(seg{i}, out)
        outSegs  = [outSegs; i];
%         plotthree(vasc(seg{i}, :),'-')
    end
end

last = length(outSegs);
stop = false;
%%
while stop == false
endpts = [];
startpts = [];
for i = 1:length(outSegs)
    endpts = [endpts; seg{outSegs(i)}(end)];
    startpts = [startpts; seg{outSegs(i)}(1)];
end

endpts = [endpts; inlet];

% find the segments that start with ids that are not in the list of end points
for i = 1:length(outSegs)
    j = outSegs(i);
    if sum(endpts==seg{j}(1)) == 0
        outSegs(i) = 0;        
%     else
%         plotthree(vasc(seg{outSegs(i)}, :), 'k-')
    end
end
tmp = outSegs(outSegs~=0);
clear outSegs
outSegs = tmp;
clear tmp
stop = last == length(outSegs);

last = length(outSegs);
end

%%
for i = 1:length(outSegs)
    hold on;
%     plotthree(vasc(seg{outSegs(i)}, :), '-')
    tmp{i} = seg{outSegs(i)};
end
clear outSegs
outSegs = tmp;
clear tmp
map = colormap('parula');
MaxGen = 100;
tree = trifPaths(outSegs, sortGens(MaxGen, outSegs, inlet));
treeplt(tree, map, vasc)