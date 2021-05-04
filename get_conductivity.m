function sigma = get_conductivity(domain,B, omega,x,y,z)
%GET_CONDUCTIVITY 
%   evalutas the the conductivity at x,y,z
%   domain  - an object of the graphene class
%   omega   - the wavelength of inclining light
%   x,y,z   - each a scalar for the position.
q = 1.60217662e-19;
h_bar = 6.62607015e-34;
c = 299792458;
m = 1;
M = m*domain.Fermi_vel^2/domain.Chem_pot;
omega_c = q*B(x,y,z)/(m*c)*M;
sigmaxx = q^2*domain.Chem_pot*1i*(omega-1i/domain.Tau)/(pi*h_bar*(omega-1i/domain.Tau...
            )^2-omega_c^2);
sigmaxy = q^2*domain.Chem_pot*omega_c/(pi*h_bar*(omega-1i/domain.Tau...
            )^2-omega_c^2);
        
sigma = [sigmaxx,sigmaxy;sigmaxy,sigmaxx];
end

