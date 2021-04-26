function b_plot(X,Y,Z,B_field,Z_value,dipole_pos,m_dipole,...
    coords_circ,phi)

%Rotationsmatrisen skapas
rot_mat = [1,0,0;0,cos(phi),-sin(phi);0,sin(phi),cos(phi)];
%Roterar cirkeln
R_circ = coords_circ*rot_mat;

%Skapar quiverplottar
quiver3(X,Y,Z,B_field(:,:,1),B_field(:,:,2)...
    ,B_field(:,:,3)) %B-fält
hold on
quiver3(dipole_pos(:,1),dipole_pos(:,2),dipole_pos(:,3), ... %Dipoler
    m_dipole(:,1),m_dipole(:,2),m_dipole(:,3),'--r','AutoScaleFactor',0.25)
xlabel('x')
ylabel('y')
zlabel('z')
plot3(R_circ(:,1),R_circ(:,2),R_circ(:,3)) %Grafenskivan
title("The B-field at Z = " + Z_value)
hold off

end