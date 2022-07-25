t = 0; b =0; j = 0;
for i = unique([edges(:, 1); edges(:, 2)])'
if length(find(all == i)) == 1
    t = t+1;
elseif length(find(all == i)) == 2
b = b+1;
else
j = j+1;
end
end
t
b
j