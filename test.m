model = createpde;
model.Geometry = gm;
mesh = generateMesh(model);
Ef2 = findElements(mesh,'region','Cell',2);
pdemesh(mesh.Nodes,mesh.Elements(:,Ef2))