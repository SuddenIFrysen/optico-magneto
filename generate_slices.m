function gm = generate_slices(r1, r2, h, H, L)
    % GENERATE_SLICES
    % Create and return DiscreteGeometry object with two thin hollow cylinders
    % within a box. Parameters:
    %   r1 - cylinder inner radius
    %   r2 - cylinder outer radius
    %   h  - cylinder height (ideally very small)
    %   H  - distance between cylinders (outer - outer)
    %   L  - large cube side length

    cyl1 = multicylinder([r1 r2], h, 'Void', [true, false]);
    cyl1 = translate(cyl1, [0, 0, H/2-h]);
    cyl2 = multicylinder([r1 r2], h, 'Void', [true, false]);
    cyl2 = translate(cyl2, [0, 0, -H/2]);

    cube = multicuboid(L, L, L);
    translate(cube, [0 0 -L/2]);
    cube = addCell(cube, cyl1);
    gm = addCell(cube, cyl2);
end