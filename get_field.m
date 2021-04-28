function B = get_field(X,Y,Z,r_dipoles, m_matrix, r_thresh)
% Returns a 3D tensor consisting of the B-field in each direction for a
% given point.
%
% X,Y,Z: Matrices such that: X = [x1,x3;x2,x4], for example
% m_m: [[m_x1,m_y1,m_z1],[m_x2,m_y2,m_z2],..]
% p_e: [[x1,y1,z1],[x2,y2,z2],..]
% r_thresh: how close we allow the dipole to be to the point we
% evaluate in. This avoids singularities.

mu_0 = 1.25663706212e-6;
dipoles_amount = size(r_dipoles,1);
position_amount = numel(X);

B = zeros(position_amount,3);
Bx = zeros(size(X));
By = zeros(size(X));
Bz = zeros(size(X));
for i = 1:position_amount
    for j = 1:dipoles_amount
        r = [X(i),Y(i),Z(i)]-r_dipoles(j,:);
        if norm(r) < r_thresh
            B(i,:) = [0,0,0]; % Force B to be 0 to avoid singularities
            break
        end
        B(i,:) = B(i,:) + (mu_0/(4*pi))*((3*r* ...
            (m_matrix(j,:)*r'))/(norm(r))^5 - ...
             m_matrix(j,:)/(norm(r))^3);
        Bx(i) = B(i,1);
        By(i) = B(i,2);
        Bz(i) = B(i,3);
    end
end

B = zeros(size(Bx,1),size(Bx,2),3);
B(:,:,1) = Bx;
B(:,:,2) = By;
B(:,:,3) = Bz;
end