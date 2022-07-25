plotthree(flipud(vasc), '.')


% only works if centred at the origin

function out = rotate(in, angle)
    angle = angle*180/pi;
    out = zeros(size(in));
    out(:, 1)= in(:, 1)*cos(angle)-in(:, 2)*sin(angle);
    out(:, 2)= in(:, 1)*sin(angle)+in(:, 2)*cos(angle);
    out(:, 3)= in(:, 3);
end