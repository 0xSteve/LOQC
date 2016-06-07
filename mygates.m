%extra gates class
classdef mygates < handle
    properties (Constant)
        Y = helper.Y;
        Z = helper.Z;
    end
    methods (Static)
        function [ U ] = PBS45(sign) 
            %assume 2 dimensional
            %sign must be +/- 1
            coeff = 1 / sqrt(2);
            if sign == 1
                Y = mygates.Y;
                Z = mygates.Z;
                Y.data(1,2) = Y.data(1,2)*(-1);
                Z.data(2,2) = Z.data(2,2)*(-1);
                U = Y + Z;
            else
                disp('sign is not 1');
            end
        end
        function [ U ] = phase(theta)
             if theta == 0
                 Z = mygates.Z;
                 Z.data(2,2) = Z.data(2,2)*(-1);
                 U = Z;
             elseif theta == (90)
                 Z = mygates.Z;
                 Z.data(2,2) = Z.data(2,2)*(-1)*(1i);
                 U = Z;
             else
                 Z = mygates.Z;
                 Z.data(2,2) = exp(1i*(theta));
                 U = Z;
             end
        end
    end
end
