function B = B_field_quadratic_profile(target_domain, Str, a, b)
%B_field_quadratic
%Generates a field with a quadratic profile over the graphene.
%   target_domain as aa struct detailed in main.mlx
%   Str as a scalar and described in eq below
%   a as a scalar and described in eq below
%   b as a scalar and described in eq below
%       The B-field over the graphene is given as B(r) = Str*(a+b*(r/R)+(r/R)^2)

r_rel = @(X,Y,Z) sqrt((X-target_domain.Origin(1)).^2 + (Y-target_domain.Origin(2)).^2 + (Z-target_domain.Origin(3)).^2 );
B = @(X,Y,Z) Str * permute(target_domain.Normal, [1 3 2]) .* (a + b*r_rel(X, Y, Z)/target_domain.R + (r_rel(X, Y, Z) / target_domain.R).^2);
end