% DEFINE FUNCTIONS AND PARAMETERS
model = createpde();

Ru = 20;    %OUTER RING DIAMETER
Ri = 12.5;    %INNER RING DIAMETER
H = 5;      %HEIGHT OF THE RING
h = 0.2;    %HEIGHT OF THE MAGNETIC CHARGE
L = 100;    %SIDE LENGTH OF CUBE
M = 1;      %THE MAGNETIZATION STRENGHT OF THE SOURCES
generate_slices(Ri,Ru,h,H,L, M, model);

f_cyl = @(r,z) (r<Ru).*(r>Ri).*(abs(z)>(H/2-h)).*(abs(z)<(H/2)).*sign(z).*M;
f_kart = @(location, state) f_cyl((location.x.^2+location.y.^2).^(1/2),location.z);

pdegplot(model,'FaceLabels','on','FaceAlpha',0.5)

%Sets the differential equation to be laplace in the whole volume, except
%in the charged areas of the ring.
%specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',f_kart);


%Applies dirichlet conditions on all the cubes faces
for i = 1:6
    applyBoundaryCondition(model,'dirichlet','Face',i,'u',0);
end
%% GENERATE MESH

%Generates the mesh. For finer mesh add both 'Hmax',l as parameters where l is
%max lenght of mesh
generateMesh(model);
% pdeplot3D(model, 'FaceAlpha', 0.5);

%% SOLVE PDE AND GRADIENT
results = solvepde(model);
disp('PDE solved!')

%Specifies the point where the gradients are evaluated. 
eval_mesh_size = 51;
viewbox_side = ceil(2*Ru/10)*10;
viewbox_height = ceil(2*H/10)*10;
[X,Y,Z] = meshgrid(linspace(-viewbox_side,viewbox_side,eval_mesh_size), ...
                   0, linspace(-viewbox_height,viewbox_height,eval_mesh_size));
[gradx,grady,gradz] = evaluateGradient(results,X,Y,Z);
phi = interpolateSolution(results,X,Y,Z);

disp('Gradient computed')

gradx = squeeze(reshape(gradx,size(X)));
grady = squeeze(reshape(grady,size(Y)));
gradz = squeeze(reshape(gradz,size(Z)));
phi = squeeze(reshape(phi, size(X)));
X = squeeze(X);
Y = squeeze(Y);
Z = squeeze(Z);

%% PLOT 3D SOLUTION

%quiver3(X,Y,Z,gradx,grady,gradz)

%Sjukt cursed plot, plotta ej denna!
%pdeplot3D(model,'ColorMapData',results.NodalSolution)

%axis equal
%xlabel('x')
%ylabel('y')
%zlabel('z')

%% PLOT 2D SOLUTION
close all
xlabel('x')
ylabel('z')
hold on
rectangle('Position', [Ri, -H/2, (Ru-Ri), H]);
rectangle('Position', [Ri, -H/2, (Ru-Ri), h], 'EdgeColor','b');
rectangle('Position', [Ri, H/2-h, (Ru-Ri), h], 'EdgeColor','r');
rectangle('Position', [-Ru, -H/2, (Ru-Ri), H]);
rectangle('Position', [-Ru, -H/2, (Ru-Ri), h], 'EdgeColor','b');
rectangle('Position', [-Ru, H/2-h, (Ru-Ri), h], 'EdgeColor','r');
quiver(X,Z,gradx,gradz)
hold off

figure()
xlabel('x')
ylabel('z')
contourf(X, Z, phi)
%% PLOTTING AGAINST VITALIY

mid = round((eval_mesh_size+1)/2);
zis = mid:5:(mid+25);
colors = ["green", "red", "cyan", "magenta", "yellow", "black", "none", "none", "none"];
figure()
hold on
for i = 1:numel(zis)
    xs = X(mid:eval_mesh_size,zis(i));
    zs = gradz(mid:eval_mesh_size,zis(i));
    plot(xs,zs, 'Color', colors(i), 'DisplayName', 'z='+ string(Z(1,zis(i))));
end

grid on

legend
hold off