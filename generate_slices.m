%% Attempt at dynamic geometry
r2 = 40;
r1 = 25;
h = 1;
H = 5;
L = 200;
cyl1 = multicylinder([r1 r2], h, 'Void', [true, false]);
cyl1 = translate(cyl1, [0 0 H/2]);
cyl2 = multicylinder([r1 r2], h, 'Void', [true, false]);
cyl2 = translate(cyl2, [0, 0, -H/2-h]);

cube = multicuboid(L, L, L);
translate(cube, [0 0 -L/2]);
cube = addCell(cube, cyl1);
gm = addCell(cube, cyl2);
pdegplot(gm, 'FaceAlpha', 0.5)