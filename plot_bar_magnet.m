function plot_bar_magnet(center, axis, height, rad)
    t1 = [0 0 1];
    if axis(1) == 0 && axis(2) == 0
        t1 = [1 0 0];
    end
    t1 = t1 - axis* sum(t1.*axis);
    t1 = t1 / sqrt(sum(t1.*t1));
    t2 = cross(axis, t1);
    theta = linspace(0, 2*pi)';
    
    Bot = center - axis * height / 2 + rad*(t1 .* cos(theta) + t2 .* sin(theta));
    Top = center + axis * height / 2 + rad*(t1 .* cos(theta) + t2 .* sin(theta));
    
    surf([Bot(:, 1) Top(:, 1)], [Bot(:, 2) Top(:, 2)], [Bot(:, 3) Top(:, 3)], 'EdgeColor', 'none', 'FaceAlpha', 0.3, 'FaceColor', 'r');
    patch(Bot(:, 1), Bot(:, 2), Bot(:, 3), 'r', 'FaceAlpha', 0.3);
    patch(Top(:, 1), Top(:, 2), Top(:, 3), 'r', 'FaceAlpha', 0.3);
    quiver3(center(1),center(2),center(3), axis(1),axis(2),axis(3),'-r','AutoScaleFactor',0.01)
end