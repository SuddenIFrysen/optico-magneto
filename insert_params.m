function M = insert_params(x, M_vars, M_coeff, M_consts)
%INSERT_PARAMS - Insert params into array
% INPUTS:
%   x        - 1 x n vector containing scalar parameter values
%   M_vars   - Array of any size, with n non-zero components pointing to an
%   index of a parameter row vector x
%   M_coeff  - Array of same size as M_vars, containing numerical
%   coefficients to multiply variables above
%   M_consts - Array of same size as M_vars, containing numerical values
%   for those indices not set in M_vars
    M = M_consts;
    
    for i = 1:numel(M_consts)
        if M_vars(i) ~= 0
            M(i) = M(i) + x(M_vars(i))*M_coeff(i);
        end
    end
end