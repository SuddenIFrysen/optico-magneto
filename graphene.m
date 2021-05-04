classdef graphene
    % GRAPHENE Class encapsulating the geometry of the graphene sheet 
    properties
        Origin
        Normal
        R
        Phi
        Chem_pot
        Fermi_vel
        Tau
    end
    
    methods
        function obj = graphene(origin, r, phi, chem_pot, fermi_vel,tau)
            % GRAPHENE Construct an instance of this class
            obj.Origin = origin;
            obj.R = r;
            obj.Phi = phi;
            obj.Normal = [0, -sin(phi), cos(phi)];
            obj.Chem_pot = chem_pot;
            obj.Fermi_vel = fermi_vel;
            obj.Tau = tau;
        end
        
        function [X, Y, Z] = Transform(obj, X_in, T_in, N_in)
            % TRANSFORM Take coordinates in a graphene-centered reference
            % frame, and return coordinates in the lab frame.
            %   INPUTS
            % X_in - Coordinates in the (lab-frame) x-direction, but
            %        measured relative to the graphene origin. Since the
            %        graphene only tilts about the x-axis, the axis will be
            %        situated in the plane. 
            % T_in - Coordinates in the other direction tangent to the
            %        plane (but orthogonal to X). For phi = 1, T = Z.
            % N_in - Coordinates in the direction normal to the plane,
            %        given by N = X x T
            X = obj.Origin(1) + X_in;
            Y = obj.Origin(2) + T_in * cos(obj.Phi) - N_in * sin(obj.Phi);
            Z = obj.Origin(3) + T_in * sin(obj.Phi) + N_in * cos(obj.Phi);
        end
    end
end
