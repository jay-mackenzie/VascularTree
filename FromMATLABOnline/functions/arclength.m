%% arclength
% finds the arc length of a 3D curve.
% give 3 parameters: x, y, and z coordinates in the line you want to
% measure
% returns the arc length of the given curve
% JAM. March 2021.
function len = arclength(xyz)
    [r, c] = size(xyz);
    if r >1
        for j = 1:r-1
            d(j, :) = dist(xyz(j, :), xyz (j+1, :));
        end
    else
        return
    end
    
    len = sum(sum(d));