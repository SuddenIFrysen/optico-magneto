% DEFINE FUNCTIONS AND PARAMETERS
model = createpde();

Ru = 20;    %OUTER RING DIAMETER
Ri = 12.5;    %INNER RING DIAMETER
H = 5;      %HEIGHT OF THE RING
h = 0.2;    %HEIGHT OF THE MAGNETIC CHARGE
L = 500;    %SIDE LENGTH OF CUBE
M = 1;      %THE MAGNETIZATION STRENGHT OF THE SOURCES
model.Geometry = generate_slices(Ri,Ru,h,H,L);

f_cyl = @(r,z) (r<Ru).*(r>Ri).*(abs(z)>(H/2-h)).*(abs(z)<(H/2)).*sign(z).*M;
f_kart = @(location, state) f_cyl((location.x.^2+location.y.^2).^(1/2),location.z);

pdegplot(model,'FaceLabels','on','FaceAlpha',0.5)

%Sets the differential equation to be laplace in the whole volume, except
%in the charged areas of the ring.
%specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',f_kart);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'cell',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',M,'cell',2);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-M,'cell',3);

%Applies dirichlet conditions on all the cubes faces
for i = 1:6
    applyBoundaryCondition(model,'dirichlet','Face',i,'u',0);
end
%% GENERATE MESH

%Generates the mesh. For finer mesh add both 'Hmax',l as parameters where l is
%max lenght of mesh
generateMesh(model);
pdeplot3D(model, 'FaceAlpha', 0.5);

%% SOLVE PDE AND GRADIENT
results = solvepde(model);

%Specifies the point where the gradients are evaluated. 
eval_mesh_size = 99;
[X,Y,Z] = meshgrid(linspace(-50,50,eval_mesh_size),linspace(-50,50,eval_mesh_size),linspace(-50,50,eval_mesh_size));
[gradx,grady,gradz] = evaluateGradient(results,X,Y,Z);

gradx = reshape(gradx,size(X));
grady = reshape(grady,size(Y));
gradz = reshape(gradz,size(Z));

%% PLOT 3D SOLUTION

quiver3(X,Y,Z,gradx,grady,gradz)

%Sjukt cursed plot, plotta ej denna!
%pdeplot3D(model,'ColorMapData',results.NodalSolution)

axis equal
xlabel('x')
ylabel('y')
zlabel('z')

%% PLOT 2D SOLUTION

xlabel('x')
ylabel('z')
slice = floor(eval_mesh_size/2)+1;

hold on
rectangle('Position', [Ri, -H/2, (Ru-Ri), H]);
rectangle('Position', [Ri, -H/2, (Ru-Ri), h], 'EdgeColor','b');
rectangle('Position', [Ri, H/2-h, (Ru-Ri), h], 'EdgeColor','r');
rectangle('Position', [-Ru, -H/2, (Ru-Ri), H]);
rectangle('Position', [-Ru, -H/2, (Ru-Ri), h], 'EdgeColor','b');
rectangle('Position', [-Ru, H/2-h, (Ru-Ri), h], 'EdgeColor','r');
quiver(X(slice,:,:),Z(slice,:,:),gradx(slice,:,:),gradz(slice,:,:))
hold off

%% PLOTTING AGAINST VITALIY

zis = slice:(slice+7);
colors = ["green", "red", "cyan", "magenta", "yellow", "black", "none", "none", "none"];

hold on
for i = zis
    xs = X(slice,slice:eval_mesh_size,i);
    zs = gradz(slice,slice:eval_mesh_size,i);
    plot(xs,zs, 'Color', colors(1+i-slice), 'DisplayName', 'z='+ string(Z(15,15,i)));
    display(colors(1+i-slice))
end

grid on

legend
hold off