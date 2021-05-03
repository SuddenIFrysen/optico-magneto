classdef ring_magnet
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        R
        Normal
        Origin
        M
        X
        F1
        F2
    end
    
    methods
        function obj = ring_magnet(R)
            %UNTITLED5 Construct an instance of this class
            %   Detailed explanation goes here
            obj.R = R;
            obj.Normal = [0 0 1];
            obj.Origin = [0 0 0];
            obj.M = 1;
            obj.X = linspace(0, 1, 1000);
            f1 = @(x) integral(@(phi) 1./(1-x.*cos(phi)).^(5/2), 0, pi);
            f2 = @(x) integral(@(phi) cos(phi)./(1-x.*cos(phi)).^(5/2), 0, pi);
            obj.F1 = arrayfun(f1, obj.X);
            obj.F2 = arrayfun(f2, obj.X);
        end
        
        function res = eval_F(obj, X, oneOrTwo)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if (oneOrTwo == 1)
                res = interp1(obj.X, obj.F1, X);
            else
                res = interp1(obj.X, obj.F2, X);
            end
        end
        
        function B = get_field(obj, X, Y, Z)
            A = sqrt(X.^2+Y.^2+Z.^2)/obj.R;
            SinT = Z ./ (A*obj.R);
            CosT = 1 - SinT.^2;
            Br = 3e-7*obj.M*A.*SinT./(pi*obj.R^3*(A.^2+1).^(5/2)).*(A.*CosT.*obj.eval_F(2*A.*CosT./(A.^2+1), 1)-obj.eval_F(2*A.*CosT./(A.^2+1), 2));
            Bz = 1e-7*obj.M./(pi*obj.R^3*(A.^2+1).^(5/2)).*((3*A.^2.*SinT.^2-A.^2-1).*obj.eval_F(2*A.*CosT./(A.^2+1), 1)+2.*A.*CosT.*obj.eval_F(2*A.*CosT./(A.^2+1), 2));
            
            Bx = X./(X.^2+Y.^2).*Br;
            By = Y./(X.^2+Y.^2).*Br;
            Bx(isnan(Bx)) = 0;
            By(isnan(By)) = 0;
            
            B = zeros(size(Bx,1),size(Bx,2),3);
            B(:,:,1) = Bx;
            B(:,:,2) = By;
            B(:,:,3) = Bz;
        end
    end
end

