function I = integral2_points(val_in_points, dx, dy)
%INTEGRAL2_POINTS Summary of this function goes here
%   Detailed explanation goes here

if dy == 0
    dy = 2*pi/height(val_in_points);
end
I = 0;
for i = 1:length(val_in_points)
    for j = 1:height(val_in_points)
        I = I + dx*dy*val_in_points(i,j);
    end
end

end

