function i = inner_prod(B1, B2)
    % INNER_PROD
    % Takes two vector-fields and calculates the GJK-Product©.
    %   B1 - First vector-field to multiply. Either function handle(r,theta
    %       )or evaluted in points as (n x 2) matrix with r pos in first 
    %       column and theta in secound column.
    %   B2 - Secound vector-field to multiply. Either function handle(r,theta
    %       )or evaluted in points as (n x 2) matrix with r pos in first 
    %       column and theta in secound column.
    
    R = 1;
    
if class(B1) == 'function_handle' && class(B2) == 'function_handle'
    f = @(r, t) r*dot(B1(r, t), B2(r,t));
    i = integral2(f, 0, R, 0, 2*pi);
end


end

