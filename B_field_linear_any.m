function b = B_field_linear_any(target_domain, Str, dir)
%B_field_linear
%Generates a field with a linear profile over the graphene.
%   target_domain as aa struct detailed in main.mlx
%   Str as a scalar and described in eq below

b = @(X,Y,Z) Str * permute(target_domain.Normal, [1 3 2]) .* (X * dir(1) + Y * dir(2) + Z * dir(3)) ./ target_domain.R;
end