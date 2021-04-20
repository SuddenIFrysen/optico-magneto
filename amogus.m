
N = 100;
Xmax = 100;
Ymax = 100;
Z = 10;

[X,Y,Z] = meshgrid(linspace(-Xmax,Xmax,N),linspace(-Ymax,Ymax,N),Z);
x = X(:);
y = Y(:);
z = Z(:);

r_eval = [x,y,z];

%Position of the dipoles
pos_dipole = [0,1,0;1,0,0;-1,0,0;0,-1,0;0.707,0.707,0;-0.707,0.707,0;
    -0.707,-0.707,0;0.707,-0.707,0];

%Magnetization of dipoles
m_dipole = [0,0,1;0,0,1;0,0,1;0,0,1;0,0,1;0,0,1;0,0,1;0,0,1];

B = okuja(pos_dipole,m_dipole,r_eval,0.011);

quiver3(x,y,z,B(:,1),B(:,2),B(:,3))