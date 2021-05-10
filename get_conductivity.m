function [sigmaxx, sigmaxy] = get_conductivity(domain,B, omega,x,y,z)
%GET_CONDUCTIVITY 
%   evaluates the the conductivity at x,y,z
%   domain  - an object of the graphene class
%   B       - the b-field of the graphene
%   omega   - the wavelength of inclining light
%   x,y,z   - each a matrix over the positions.
q = 1.60217662e-19;
h_bar = 6.62607015e-34;
c = 299792458;
m = 1;
M = m*domain.Fermi_vel^2/domain.Chem_pot;
Bf = B(x,y,z);
normal_tensor = cat(3, ones([width(Bf),height(Bf)])*domain.Normal(1), ones([width(Bf),height(Bf)])*domain.Normal(2), ones([width(Bf),height(Bf)])*domain.Normal(3));

omega_c = q*dot(normal_tensor,Bf,3)/(m)*M;
sigmaxx = q^2*domain.Chem_pot*1i*(omega-1i/domain.Tau)./(pi*h_bar*(omega-1i/domain.Tau...
            )^2-omega_c^2);
sigmaxy = q^2*domain.Chem_pot*omega_c./(pi*h_bar*(omega-1i/domain.Tau...
            )^2-omega_c^2);
end
