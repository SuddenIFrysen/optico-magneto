function b = B_field_linear_x(target_domain, Str)
%B_field_linear
%Generates a field with a linear profile over the graphene.
%   target_domain as aa struct detailed in main.mlx
%   Str as a scalar and described in eq below
%   a as a scalar and described in eq below
%       The B-field over the graphene is given as B(r) = Str*(a+r)

Phi = target_domain.Phi;
n = [0, -sin(Phi), cos(Phi)];
b = @(x,y,z) Str * n * x;
end