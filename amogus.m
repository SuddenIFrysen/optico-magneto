N = 10; %Antalet punkter i rummet
Xmax = 10;
Ymax = 10;
Z = 10;

r = 0.5; %Ringens radie
amount_dipoles = 8;
theta = linspace(0,2*pi,amount_dipoles+1);

%Sätter dipolerna på en ring, rör inte detta
x_dipoles = r*cos(theta(1:amount_dipoles))';
y_dipoles = r*sin(theta(1:amount_dipoles))';
z_dipoles = zeros(amount_dipoles,1); % Rör möjligtvis detta

[X,Y,Z] = meshgrid(linspace(-Xmax,Xmax,N),linspace(-Ymax,Ymax,N),Z);

%Position of the dipoles
%pos_dipole = [0,1,0;1,0,0;-1,0,0;0,-1,0;0.707,0.707,0;-0.707,0.707,0;
%    -0.707,-0.707,0;0.707,-0.707,0];

pos_dipole = [x_dipoles,y_dipoles,z_dipoles];

%Magnetization of dipoles
%m_dipole = [0,0,1;0,0,1;0,0,1;0,0,1;0,0,1;0,0,1;0,0,1;0,0,1];

m_dipole = repmat([0,0,1],amount_dipoles,1);

B = okuja(X,Y,Z,pos_dipole,m_dipole,0.011);

B_normalized = zeros(size(B));
%Normaliserar B
%VARNING EXTREMT CURSED
for i = 1:height(B_normalized)
    for j = 1:width(B_normalized)
        B_normalized(i,j,:) = B(i,j,:)/norm(squeeze(B(i,j,:)));
    end
end

quiver3(X,Y,Z,B_normalized(:,:,1),B_normalized(:,:,2),B_normalized(:,:,3))
