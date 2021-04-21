function f = inner_product(R, origo, phi)
%INNER_PRODUCT
%   R - The radius of the graphene.
%   origo - The center point of the graphene, as a (3 x 1) vector.
%   phi - The angle which the graphene is rotated around the î-vector

f = @(B1, B2) integra(B1, B2, R, origo, phi);
end

function i = integra(B1, B2, R, origo, phi)
    integrand_kart = @(x, y, z) dot(B1(x, y, z), B2(x, y, z), 3);
    integrand_circ = @(r, t) r*integrand_kart(r.*cos(t)+origo(1), r.*sin(t)*cos(phi)+origo(2), r.*sin(t)*sin(phi));
    i = integral2(integrand_circ, 0, R, 0, 2*pi);
end