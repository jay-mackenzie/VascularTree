function [q1, q2, q3, IQR] = median_Jay(vector)

l = length(vector);
vector = sort(vector);


if mod(l, 4) == 0
    q1 = (vector(l/4)+vector(l/4+1))/2;
    q2 = (vector(l/2)+vector(l/2+1))/2;
    q3 = (vector(3*l/4)+vector(3*l/4+1))/2;
elseif mod(l+1, 4) == 0
    q1 = vector(ceil(l/4));
    q2 = vector(ceil(l/2));
    q3 = vector(ceil(3*l/4));
elseif mod(l+2, 4) == 0
    q1 = vector(ceil(l/4));
    q2 = (vector(l/2)+vector(l/2+1))/2;
    q3 = vector(ceil(3*l/4));
elseif mod(l+3, 4) == 0    
    q1 = (vector(floor(l/4))+vector(ceil(l/4)))/2;
    q2 = vector(ceil(l/2));
    q3 = (vector(floor(3*l/4+1))+vector(ceil(3*l/4+1)))/2;
end

IQR = q3-q1;