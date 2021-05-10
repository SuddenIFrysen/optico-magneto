function plot_graphene(X, Y, Z, Bx, By, Bz, domain)

theta = 0:2*pi/500:2*pi;
[x_circ, y_circ, z_circ] = domain.Transform(domain.R*cos(theta),domain.R*sin(theta),zeros(size(theta)));
R_circ = [x_circ', y_circ', z_circ'];

quiver3(X,Y,Z,Bx,By,Bz, 'b') %B-fält
plot3(R_circ(:,1),R_circ(:,2),R_circ(:,3), 'b') %Grafenskivan

end