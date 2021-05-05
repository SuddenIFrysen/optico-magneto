function b = B_field_uniform_Z(target_domain, Str)
%B_field_uniform_Z
%   Gives back a uniform strength field in the normal direction to the 
%   graphene. 
%   Str - The value of the magnetic field. 
b = @(X,Y,Z) Str*permute(target_domain.Normal, [1 3 2]).*ones(size(X));
end