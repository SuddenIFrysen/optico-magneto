function [pos, m] = generate_dipole_ring(new_origo, normal_vector, n, R)
% generate_dipole_ring
%   Generates a ring with n dipoles, centered at a specific location at a 
%   given radius with a given normal vector
%   new_origo - A vector where the ring will be centered in 3D-space.
%   normal_vector - A vector which the plane containing the dipoles is 
%                   perpendicular to
%   n - number of dipoles in the ring
%   R - the radius of the ring

theta = linspace(0, 2*pi, n+1);
theta = theta(1:end-1);
normal_vector = normal_vector/(norm(normal_vector));
if width(normal_vector) == 3
    normal_vector = normal_vector';
end
Z = [0;0;1];

if normal_vector == Z
    rot_matrix = eye(3);
else
    Finv = [Z, (normal_vector-(dot(Z, normal_vector)*Z))*1/norm(normal_vector-(dot(Z, normal_vector)*Z)) ,cross(normal_vector, Z)];
    G = [dot(Z, normal_vector),  -norm(cross(Z, normal_vector)), 0; norm(cross(Z, normal_vector)), dot(Z,normal_vector), 0; 0,0,1];
    rot_matrix = Finv*G/Finv;
end

pos_dipole = [R*cos(theta);R*sin(theta);zeros(size(theta))];
pos_dipole = rot_matrix*pos_dipole;
pos = pos_dipole' + new_origo;
end

