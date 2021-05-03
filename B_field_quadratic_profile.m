function b = B_field_quadratic_profile(target_domain, Str, a, b)
%B_field_quadratic
%Generates a field with a quadratic profile over the graphene.
%   target_domain as aa struct detailed in main.mlx
%   Str as a scalar and described in eq below
%   a as a scalar and described in eq below
%   b as a scalar and described in eq below
%       The B-field over the graphene is given as B(r) = Str*(a+b*r+r^2)

Phi = target_domain.Phi;
r_rel = @(x,y,z) sqrt( (x-target_domain.Origin(1))^2 + (y-target_domain.Origin(2))^2 + (z-target_domain.Origin(3))^2 );
b = @(x,y,z) Str*[0, -sin(Phi)*(a + b*r_rel(x,y,z)+r_rel(x,y,z)^2), cos(Phi)*(a + b*r_rel(x,y,z)+r_rel(x,y,z)^2)];
end