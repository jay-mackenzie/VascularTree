load data/vasc.dat

for i = 150
xyz = rt(i, vasc);
[t, xyz] = mercatorProjection(xyz);
plot(t, xyz(:, 3), '.')
end
save xyz
save t


function XYZ = rt(theta, XYZ)
% function rotate(theta, XYZ)
theta = (theta*pi)/180;
Q = [cos(theta), -sin(theta); sin(theta) cos(theta)];
for i = 1:length(XYZ)
    XYZ(i, 1:2) = [Q*XYZ(i, 1:2)']';
end
XYZ;
end
