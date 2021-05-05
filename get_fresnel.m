function [rplus,tplus,rminus,tminus] = get_fresnel(domain,B,omega,x,y,z)
%GET_FRESNEL returns the frensel coefficients over graphene
%   domain  - an object of the graphene class
%   B       - the b-field of the graphene
%   omega   - the wavelength of inclining light
%   x,y,z   - each a matrix over the positions.

[sigmaxx, sigmaxy] = get_conductivity(domain,B,omega,x,y,z);
c = 299792458;
aplus =  2*pi*(sigmaxx+1i*sigmaxy)/c;
aminus =  2*pi*(sigmaxx-1i*sigmaxy)/c;
rplus = -aplus./(1+aplus);
rminus = -aminus./(1+aminus);
tplus = 1./(1+aplus);
tminus = 1./(1+aminus);
end

