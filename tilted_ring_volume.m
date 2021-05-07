function [V, w] = tilted_ring_volume(vac_rad, ring_proj_rad)
    w = sqrt(2)*(ring_proj_rad-vac_rad);
    V = 2*pi*ring_proj_rad*sqrt(2).*w.^2;