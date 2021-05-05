function b_plot(X,Y,Z,Bx, By, Bz,dipole_pos,m_dipole, domain, ring_pos, ring_rad, ring_n)

theta = 0:2*pi/500:2*pi;
[x_circ, y_circ, z_circ] = domain.Transform(domain.R*cos(theta),domain.R*sin(theta),zeros(size(theta)));
R_circ = [x_circ', y_circ', z_circ'];
% %Rotationsmatrisen skapas
% rot_mat = [1,0,0;0,cos(phi),-sin(phi);0,sin(phi),cos(phi)];
% %Roterar cirkeln
% R_circ = coords_circ*rot_mat;

%Skapar quiverplottar
quiver3(X,Y,Z,Bx,By,Bz, 'b') %B-fält
hold on
if height(dipole_pos) > 0
    quiver3(dipole_pos(:,1),dipole_pos(:,2),dipole_pos(:,3), ... %Dipoler
        m_dipole(:,1),m_dipole(:,2),m_dipole(:,3),'--r','AutoScaleFactor',0.25)
end
xlabel('x')
ylabel('y')
zlabel('z')
plot3(R_circ(:,1),R_circ(:,2),R_circ(:,3), 'b') %Grafenskivan
if height(ring_pos) > 0
    for i = 1:height(ring_pos)
        t1 = [0 0 1];
        if ring_n(i, 1) == 0 && ring_n(i, 2) == 0
            t1 = [1 0 0];
        end
        t1 = t1 - ring_n(i, 2) * sum(t1.*ring_n(i, :));
        t1 = t1 / sqrt(sum(t1.*t1));
        t2 = cross(ring_n(i, :), t1);
        R_ring = ring_pos(i, :) + ring_rad(i)*cos(theta') .* t1 + ring_rad(i)*sin(theta') .* t2;
        plot3(R_ring(:,1),R_ring(:,2),R_ring(:,3), 'r') %Alla ringar
    end
    plot3(R_circ(:,1),R_circ(:,2),R_circ(:,3), 'b') %Grafenskivan
end

title("The B-field evaluated on graphene")
hold off
end