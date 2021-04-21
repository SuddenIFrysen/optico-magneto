function b = B_field_linear_profile(target_domain, Str, a)
%B_field_linear
%Generates a field with a linear profile over the graphene.
%   target_domain as aa struct detailed in main.mlx
%   Str as a scalar and described in eq below
%   a as a scalar and described in eq below
%       The B-field over the graphene is given as B(r) = Str*(a+r)

Phi = target_domain.Phi;
r_rel = @(x,y,z) sqrt( (x-target_domain.Origin(1))^2 + (y-target_domain.Origin(2))^2 + (z-target_domain.Origin(3))^2 );
b = @(x,y,z) Str*[0, -sin(Phi)*(a + r_rel(x,y,z)), cos(Phi)*(a + r_rel(x,y,z))];
end