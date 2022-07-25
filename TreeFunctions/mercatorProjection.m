% mercator projection
% takes a point x, y, and a position \in [0, 2pi] of a discontinuity in the plot
% first, map the point to the surface of the unit circle centred at the
% origin, then unwrap the circle, so the angle between the positive
% direction and the line between the origin and (x, y) becomes the new
% horizontal coordinate, and use the original height as the vertical
function [theta, xyz] = mercatorProjection(xyz)
    % map to cylinder
    x = xyz(:, 1);
    y = xyz(:, 2); 
    m = sqrt(x.^2 + y.^2);
    x = x./m;
    y = y./m; 
%     gap = gap * pi/180

    % unwrap the cylinder
    theta = atan(y./x);
    for i = 1:length(x)
	if x(i)<0
        theta(i) = theta(i)+pi;
    elseif x(i)>=0 && y(i)<0
        theta(i) = theta(i)+2*pi;
    end
    end
    
%     xyz = [x y xyz(:, 3)];
%     %% is there a discontinuity? move the tree to get rid of this
%     if theta > gap
%         theta = theta - 2*pi;
%     end

%     theta = theta+2*pi;

%     theta = [theta];
