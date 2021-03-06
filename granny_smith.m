function [x, B_best] = granny_smith(B, B_0, inprod, n, verbose)
%GRANNY_SMITH Find best coefficients for a projection problem
%   
% Given a function handle to compute a property B from a coefficient
% vector, an ideal reference B, a function handle inprod(B1, B2), and a
% number of degrees of freedom n, perform Gram-Schmidt orthogonalization
% and find a suitable parameter vector x.
%   INPUT
% B      - Funciton handle. Example: b([x1, x2, ..., xn]).
%          computes the relevant property, that is to be sent to the inner
%          product function. In our case, the result can be a B field 
%          evaluated at a certain interesting grid of points, or even a 
%          function handle to a B-field computer. Adjust the inprod 
%          function handle accordingly. OBS!!! MUST BE COMPATIBLE WITH
%          VECTOR ALGEBRA, I.E. OVERLOAD CORRESPONDING OPERATORS!!!
% B_0    - Reference value. Must be of the same type as the return value of
%          B, i.e. a type accepted by inprod.
% inprod - Function handle. Example: inprod(B1, B2).
%          Computes a satisfying inner product of two results. B1 and B2
%          can for example be B field evaluated on a relevant grid, or
%          function handles. This function handle must be implemented
%          accordingly.
% n      - Number of degrees of freedom. More specifically, B must take a
%          1x3 vector of real numbers as its only argument. 
    if nargin == 4
        verbose = false;
    end
    
    V = cell(1, n); % To store the basis vectors corresponding to the original basis
    M = zeros(n); % To store the change-of-basis matrix from ON-basis to original basis
    
    for i = 1:n
        x = zeros(1, n);
        x(i) = 1;
        V{i} = B(x);
    end
    
    E = cell(1, n);
    for i = 1:n
        E{i} = V{i};
        for j = 1:(i-1)
            if verbose
                disp(['Starting to compute inner product between ' num2str(i) ' and ' num2str(j)])
                tic
            end
            M(j,i) = inprod(E{j}, V{i});
            if verbose
                disp(['It took ' num2str(toc) ' s'])
            end
            E{i} = E{i} - M(j, i)*E{j};
        end
        if verbose
            disp(['Starting to compute inner product between ' num2str(i) ' and ' num2str(i)])
            tic
        end
        M(i, i) = sqrt(inprod(E{i}, E{i}));
        if verbose
            disp(['It took ' num2str(toc) ' s'])
        end
        E{i} = E{i} / M(i, i);
    end
    
    x = zeros(1, n);
    for i = 1:n
        if verbose
            disp(['Starting to compute inner product between target and ' num2str(i)])
            tic
        end
        x(i) = inprod(B_0, E{i});
        if verbose
            disp(['It took ' num2str(toc) ' s'])
        end
    end
    x = (M\(x'))';
    B_best = B(x);
end