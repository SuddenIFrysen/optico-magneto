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
    integrand = @(r, t) r*dot(B1(r,t), B2(r,t));
    integrand_in_points = zeros(100,100);
    for i = 1:length(integrand_in_points)
        for j = 1:height(integrand_in_points)
            integrand_in_points(i,j) = integrand((i-0.5)/100, j/100*2*pi);
        end
    end
    i = integral2_points(integrand_in_points, 1/100, 2*pi/100);
end



end
