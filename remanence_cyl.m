function B = remanence_cyl(moment, rad, h)
    V = h*pi*rad^2;
    B = 4e-7*pi*moment/V;
end