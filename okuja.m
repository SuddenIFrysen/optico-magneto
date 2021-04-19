function B = okuja(r_dipoles, m_matrix, r_eval)
% Lös alla dipolers B-fältsbidrag i den givna
% För att få ut B-fält, summera allas bidrag

% p_d: [[x1,y1,z1],[x2,y2,z2],..]
% m_m: [[m_x1,m_y1,m_z1],[m_x2,m_y2,m_z2],..]
% p_e: [[x1,y1,z1],[x2,y2,z2],..]

mu_0 = 1.25663706212e-6;
dipoles_amount = size(r_dipoles,1);
position_amount = size(r_eval,1);

B = zeros(position_amount,3);

for i = 1:position_amount
    for j = 1:dipoles_amount
        r = r_eval(i,:)-r_dipoles(j,:);
        B(i,:) = B(i,:) + (mu_0/(4*pi))*((3*r* ...
            (m_matrix(j,:)*r'))/(norm(r))^5 - ...
             m_matrix(j,:)/(norm(r))^3);
    end
end