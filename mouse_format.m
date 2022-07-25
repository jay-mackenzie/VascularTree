arcs = load('arcs.mat');
arcs = arcs.arcs_p1C1;

vasc = [];
rad = [];
edges = [];
inits = [];
terms = [];
% figure;hold on;
for i = 1:length(arcs)
%     subplot(2, 1, 1)
%     plotthree(arcs{i}(2:end, :), '-'); hold on
%     subplot(2, 1, 2)
%     plotthree(arcs{i}(2:(length(arcs{i})-2):end, :), '-'); hold on
    
    vasc = [vasc; arcs{i}(2:end, 1:3)];
    rad = [rad; arcs{i}(2:end, 4)];
    inits = [inits; arcs{i}(2, 1:3)];
    terms = [terms; arcs{i}(end, 1:3)];
end

for i = 1:2
subplot(2, 1, i); axis image off
view(3)
end
vasc(:, 3) =-vasc(:, 3);
rad

%% make list of edges
edges = [];
start = 1;
for i = 1:length(arcs)
    arcs{i}(:, 5) = zeros(size(arcs{i}(:, 4)));
    arcs{i}(2:end, 5) = start:start+length(arcs{i}(2:end, 5))-1;
    arcs{i}(2:end-1, 6) = arcs{i}(3:end, 5);
    edges = [edges; arcs{i}(2:end-1, 5:6)];
    start = start + length(arcs{i}(2:end, 5));
end
arcs{1}
edges

%%

for i = 1:length(arcs)
end