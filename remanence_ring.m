function B = remanence_ring(moment, in_rad, out_rad, h)
    V = h*(out_rad^2-in_rad^2)*pi;
    B = 4e-7*pi*moment/V;
end