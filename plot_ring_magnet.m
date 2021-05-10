function plot_ring_magnet(center, normal, inrad, outrad, height)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    t1 = [0 0 1];
    if normal(1) == 0 && normal(2) == 0
        t1 = [1 0 0];
    end
    t1 = t1 - normal * sum(t1.*normal);
    t1 = t1 / sqrt(sum(t1.*t1));
    t2 = cross(normal, t1);
    
    theta = linspace(0, 2*pi)';
    BotIn = center - normal * height / 2 + inrad*(t1.*cos(theta) + t2 .*sin(theta));
    BotOut = center - normal * height / 2 + outrad*(t1.*cos(theta) - t2 .* sin(theta));
    TopIn = BotIn + normal * height;
    TopOut = BotOut + normal * height;
    Bot = [BotIn(:, :); BotOut(end:-1:1, :)];
    Top = [TopIn(:, :); TopOut(end:-1:1, :)];
    
    % Top and bottom lid
    patch(Bot(:, 1), Bot(:, 2), Bot(:, 3), 'r', 'FaceAlpha', 0.3, 'LineStyle', 'none');
    patch(Top(:, 1), Top(:, 2), Top(:, 3), 'r', 'FaceAlpha', 0.3, 'LineStyle', 'none');   
    % Lines
    plot3(TopIn(:, 1), TopIn(:, 2), TopIn(:, 3), 'k');
    plot3(BotIn(:, 1), BotIn(:, 2), BotIn(:, 3), 'k');
    plot3(TopOut(:, 1), TopOut(:, 2), TopOut(:, 3), 'k');
    plot3(BotOut(:, 1), BotOut(:, 2), BotOut(:, 3), 'k');
    % Mid section
    surf([BotIn(:, 1) TopIn(:, 1)], [BotIn(:, 2) TopIn(:, 2)], [BotIn(:, 3) TopIn(:, 3)], 'EdgeColor', 'none', 'FaceAlpha', 0.3, 'FaceColor', 'r');
    surf([BotOut(:, 1) TopOut(:, 1)], [BotOut(:, 2) TopOut(:, 2)], [BotOut(:, 3) TopOut(:, 3)], 'EdgeColor', 'none', 'FaceAlpha', 0.3, 'FaceColor', 'r');
end

