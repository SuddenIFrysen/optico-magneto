function b = B_field_linear_profile(target_domain, Str, a)
%B_field_linear
%Generates a field with a linear profile over the graphene.
%   target_domain as aa struct detailed in main.mlx
%   Str as a scalar and described in eq below
%   a as a scalar and described in eq below
%       The B-field over the graphene is given as B(r) = Str*(a+r/R)

r_rel = @(X,Y,Z) sqrt((X-target_domain.Origin(1)).^2 + (Y-target_domain.Origin(2)).^2 + (Z-target_domain.Origin(3)).^2);
b = @(X,Y,Z) Str*(a+r_rel(X, Y, Z) ./ target_domain.R) .* permute(target_domain.Normal, [1 3 2]);
end