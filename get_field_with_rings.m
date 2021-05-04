
function B = get_field_with_rings(X,Y,Z,r_dipoles, r_rings, n_rings, rad_rings, m_dipoles, mz_rings, xx, f1, f2)
% Returns M x N x 3 array of B-field values. B(i,j,1) correspond to the 
% B-field in the x-direction at position [X(i,j), Y(i,j), Z(i,j)]. The
% array structure of X, Y and Z have no significance in the calculations,
% but are allowed for easy evaluation of the field in a 2D-mesh embedded in
% 3D space. 
%
%   X, Y, Z:    M x N coordinate matrices
%   r_dipoles:  L x 3 coordinate matrix, where L is the number of dipoles.
%               The second dimension correspond to x-, y- and z-coordinates
%               of the dipoles.
%   r_rings:    K x 3 coordinate matrix. Same as for r_dipoles, but with
%               ring magnet centers.
%   n_rings:    K x 3 matrix, containing normalized vectors perpendicular
%               to the ring.
%   n_rings:    K x 1 matrix, containging the radius for each ring.
%   m_dipoles:  L x 3 matrix containing m_x, m_y and m_z-values for every
%               dipole.
%   mz_rings:   K x 1 matrix. Containing magnetization values along the
%               normal direction, for every ring magnet. 
%   xx, f1, f2: Helper vectors (1 x J) with precomputed values for f1 and
%               f2. 

%% Dipoles
% Convert all entries to the following array notation:
% Matrix(n_eval_point, n_dipole, dimension)
% I.e., all quantities are of size M*N x L x 3

M = height(X);
N = width(X);

R = cat(3, X(:), Y(:), Z(:));

B = zeros(M*N, 1, 3);
if height(r_dipoles) > 0
    R_dipoles = permute(r_dipoles, [3, 1, 2]);
    m_dipoles = permute(m_dipoles, [3, 1, 2]);

    R_rel_dipole = R - R_dipoles;
    r_rel_dipole = sqrt(sum(R_rel_dipole.^2, 3));

    B_from_dipoles = sum(1e-7*(3*sum(R_rel_dipole.*m_dipoles, 3).*R_rel_dipole./r_rel_dipole.^5 - m_dipoles./r_rel_dipole.^3), 2);
    B = B_from_dipoles;
end

%% Rings
% Use the same array setup
if height(r_rings) > 0
    R_rings = permute(r_rings, [3 1 2]);
    N_rings = permute(n_rings, [3 1 2]);
    Rad_rings = rad_rings';
    Mz_rings = mz_rings';

    R_rel_rings = R - R_rings;
    r_rel_rings = sqrt(sum(R_rel_rings.^2, 3));
    a = r_rel_rings ./ Rad_rings; % Relative distance
    z = sum(R_rel_rings .* N_rings, 3); % Position relative orientation axis
    SinT = z ./ r_rel_rings;
    CosT = sqrt(1 - SinT.^2);
    F_arg = 2*a.*CosT./(a.^2+1);
    F1 = interp1(xx, f1, F_arg);
    F2 = interp1(xx, f2, F_arg);

    Br = 3e-7/pi * Mz_rings .* a .* SinT ./ (Rad_rings.^3 .* (a.^2 + 1).^(5/2)) .* (a .* CosT .* F1 - F2);
    Bz = 1e-7/pi * Mz_rings ./ (Rad_rings.^3 .* (a.^2 + 1).^(5/2)) .* ((3*a.^2 .* SinT.^2 - a.^2 - 1) .* F1 + 2*a.*CosT.*F2);

    radial_hat = (R_rel_rings - z .* N_rings);
    radial_hat = radial_hat ./ sqrt(sum(radial_hat.^2, 3));
    B = B + sum(Bz .* N_rings + Br .* radial_hat, 2);
end

B = reshape(B, M, N, 3);