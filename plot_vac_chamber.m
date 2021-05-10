function plot_vac_chamber()
    [X_cyl,Y_cyl,Z_cyl] = cylinder(0.014);
    Z_cyl = 0.1*Z_cyl-0.05;
    surf(X_cyl,Y_cyl,Z_cyl, 'FaceColor', [0.1,0.1,0.1], 'FaceAlpha', 0.1);
    surf(Y_cyl,Z_cyl,X_cyl, 'FaceColor', [0.1,0.1,0.1], 'FaceAlpha', 0.1);
end

