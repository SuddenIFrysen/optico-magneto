% DEFINE FUNCTIONS AND PARAMETERS
model = createpde();

Ru = 40;
Ri = 25;
H = 5;
h = 1;
L = 100;
model.Geometry = generate_slices(Ri,Ru,h,H,L);

pdegplot(model,'CellLabels','on','FaceAlpha',0.5)


specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'cell',1);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',1,'cell',2);
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-1,'cell',3);

%Face 2 är botten och Face 3 är toppen

%applyBoundaryCondition(model,'dirichlet','Face',2,'u',-1);
%applyBoundaryCondition(model,'dirichlet','Face',3,'u',1);
%applyBoundaryCondition(model,'dirichlet','Face',1,'u',0);
%applyBoundaryCondition(model,'dirichlet','Face',4,'u',0);
for i = 1:6
    applyBoundaryCondition(model,'dirichlet','Face',i,'u',0);
end
%% GENERATE MESH

generateMesh(model);%,'Hmax',4);

pdeplot3D(model, 'FaceAlpha', 0.5);

%% SOLVE PDE AND GRADIENT
results = solvepde(model);

mesh_size = 99;

[X,Y,Z] = meshgrid(linspace(-50,50,mesh_size),linspace(-50,50,mesh_size),linspace(-50,50,mesh_size));
[gradx,grady,gradz] = evaluateGradient(results,X,Y,Z);

gradx = reshape(gradx,size(X));
grady = reshape(grady,size(Y));
gradz = reshape(gradz,size(Z));


%% PLOT 3D SOLUTION
%pdeplot3D(model,'ColorMapData',results.NodalSolution)

%fans = fhaha((X.^2+Y.^2).^(1/2), Z);
%dom = fans ~= 0;
%scatter3(X(dom), Y(dom), Z(dom));
quiver3(X,Y,Z,gradx,grady,gradz)
%hold on

axis equal
xlabel('x')
ylabel('y')
zlabel('z')

%% PLOT 2D SOLUTION

xlabel('x')
ylabel('z')
slice = floor(mesh_size/2)+1;

hold on
rectangle('Position', [Ri, -H/2-h, (Ru-Ri), H+2*h]);
rectangle('Position', [-Ru, -H/2-h, (Ru-Ri), H+2*h]);
quiver(X(slice,:,:),Z(slice,:,:),gradx(slice,:,:),gradz(slice,:,:))


%% PLOTTING AGAINST VITALIY

zis = slice:(slice+7);

hold on
for i = zis
    xs = X(slice,slice:mesh_size,i);
    zs = gradz(slice,slice:mesh_size,i);
    plot(xs,zs, 'DisplayName', 'z='+ string(Z(15,15,i)));
end
legend
    