function b = B_field_uniform_Z(target_domain, Str)
%B_field_uniform_Z
%   Gives back a uniform strength field in the normal direction to the 
%   graphene. 
%   Str - The value of the magnetic field. 
b = @(x,y,z) Str*[0,-sin(target_domain.Phi),cos(target_domain.Phi)];
end