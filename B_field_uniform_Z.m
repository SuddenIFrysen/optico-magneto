function b = B_field_uniform_Z(target_domain, Str)
%B_field_uniform_Z
b = @(x,y,z) str*[0,-sin(target_domain.Phi),cos(target_domain.Phi)];
end