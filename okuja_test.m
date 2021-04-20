N = 21;
d = 0.5;
%[X1,Y1,Z1] = meshgrid(-1:0.1:-d,-1:0.1:1,0);
%[X2,Y2,Z2] = meshgrid(d:0.1:1,-1:0.1:1,0);
%[X3,Y3,Z3] = meshgrid(-(d-0.1):0.1:(d-0.1),d:0.1:1,0);
%[X4,Y4,Z4] = meshgrid(-(d-0.1):0.1:(d-0.1),-1:0.1:-d,0);

%x = [X1(:);X2(:);X3(:);X4(:)];
%y = [Y1(:);Y2(:);Y3(:);Y4(:)];
%z = [Z1(:);Z2(:);Z3(:);Z4(:)];

[X,Y,Z] = meshgrid(linspace(-1,1,N),linspace(-1,1,N),0);

x = X(:);
y = Y(:);
z = Z(:);

r_eval = [x,y,z];

pos_dipol = [1,1,0;-1,1,0;0,0,0];
m = [0,1,0;1,0,0;0,1,0];

B = okuja(pos_dipol,m,r_eval,0.11);
%B1 = reshape(B(:,1),N,N);
%B2 = reshape(B(:,2),N,N);

quiver(x,y,B(:,1),B(:,2))