function I = integral2_points(val_in_points, dx, dy)
%INTEGRAL2_POINTS Summary of this function goes here
%   Detailed explanation goes here

if dy == 0
    dy = 2*pi/height(val_in_points);
end
I = dx*dy*all(val_in_points);
end

