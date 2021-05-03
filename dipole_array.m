function dipole_pos = dipole_array(xs, ys, zs)
    [X, Y, Z] = meshgrid(xs, ys, zs);
    dipole_pos = [X(:), Y(:), Z(:)];
end