function M = insert_params(x,M_temp)
%INSERT_PARAMS - Insert params into array
% INPUTS:
%   x      - 1 x n vector containing scalar parameter values
%   M_temp - Array of any size, with n amount of NaN-values, where x(i) are
%            inserted.
    M = M_temp;
    i = 1;
    for j = 1:numel(M)
        if isnan(M(j))
            M(j) = x(i);
            i = i + 1;
        end
    end
end
