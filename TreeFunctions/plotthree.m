function plotthree(points, marker)
    hold on
    plot3(points(:, 1), points(:, 2), points(:, 3), marker,...
        'linewidth', 4);
    hold off