% DEFINE FUNCTIONS AND PARAMETERS
model = createpde();
importGeometry(model,'1mcube-ringmagnet.stl');

pdegplot(model,'FaceLabels','on','FaceAlpha',0.5)

CA = specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0);

%Face 2 är botten och Face 3 är toppen

applyBoundaryCondition(model,'dirichlet','Face',2,'u',-1);
applyBoundaryCondition(model,'dirichlet','Face',3,'u',1);
applyBoundaryCondition(model,'dirichlet','Face',1,'u',0);
applyBoundaryCondition(model,'dirichlet','Face',4,'u',0);
for i = 5:10
    applyBoundaryCondition(model,'dirichlet','Face',i,'u',0);
end
%% GENERATE MESH

generateMesh(model,'Hmax',25);

pdeplot3D(model);

%% SOLVE PDE AND GRADIENT
results = solvepde(model);

mesh_size = 3;

[X,Y,Z] = meshgrid(linspace(-40,40,mesh_size),linspace(-40,40,mesh_size),linspace(-40,40,mesh_size));
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

quiver(X(slice,:,:),Z(slice,:,:),gradx(slice,:,:),gradz(slice,:,:))