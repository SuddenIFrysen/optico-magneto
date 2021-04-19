function generate_slices(r1, r2, h, H, L, M, model)
    % GENERATE_SLICES
    % Modify a model object by setting the geometry to two "magnetically 
    % charged" slices. Parameters:
    %   r1 - cylinder inner radius
    %   r2    - cylinder outer radius
    %   h     - cylinder height (ideally very small)
    %   H     - distance between cylinders (outer - outer)
    %   L     - large cube side length
    %   M     - magnetization in z-direction
    %   model - PDE model to modify

    cyl1 = multicylinder([r1 r2], h, 'Void', [true, false]);
    cyl1 = translate(cyl1, [0, 0, H/2-h]);
    cyl2 = multicylinder([r1 r2], h, 'Void', [true, false]);
    cyl2 = translate(cyl2, [0, 0, -H/2]);

    cube = multicuboid(L, L, L);
    translate(cube, [0 0 -L/2]);
    cube = addCell(cube, cyl1);
    gm = addCell(cube, cyl2);
    
    model.Geometry = gm;
    specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',0,'cell',1);
    specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',M/h,'cell',2);
    specifyCoefficients(model,'m',0,'d',0,'c',1,'a',0,'f',-M/h,'cell',3);
end