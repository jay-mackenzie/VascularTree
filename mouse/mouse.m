% mouse.m

run find_next.m
run vol.m


function plotthree(points, marker)
    plot3(points(:, 1), points(:, 2), -points(:, 3), marker);
end

function plot_mouse(arcs)
    figure;
    for i = 1:length(arcs)
        plotthree(arcs{i}(2:end, 1:3), '-')
        hold on
    end
    axis equal
end