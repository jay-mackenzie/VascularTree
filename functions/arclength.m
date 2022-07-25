%% arclength
% finds the arc length of a 3D curve.
% give 3 parameters: x, y, and z coordinates in the line you want to
% measure
% returns the arc length of the given curve
% JAM. March 2021.
% function [len, d]= arclength(xyz)
function d = arclength(xyz)
    [r, c] = size(xyz);
    if r >1
        for j = 1:r-1
            d(j, :) = sum((xyz (j+1, :)-xyz(j, :)).^2);
        end
    else
        return
    end
    
    len = sum(sum(d));
end