classdef B_function
    % B_FUNCTION Description of a B-field with a handle to evaluation
    % function. Parameter vectors must be specified to allow vector 
    % operations. These operation assumes that the evaluation method is the
    % same; only the local parameters are added, and the first objects
    % handle is used.
    
    properties
        params double
        handle function_handle
    end
    
    methods
        function obj = B_function(handle, params)
            %B_FUNCTION Construct an instance of this class
            %   INPUTS
            % handle - Function handle which takes 1 object-specific
            %          (local) parameter long vision, along with any amount of
            %          external inputs.
            % params - Internal params in the shape of a row vector.
            
            if nargin == 1
                obj.params = 5;
            else
                obj.params = params;
            end
            obj.handle = handle;
        end
        
        function res = plus(obj1,obj2)
            res = B_function(obj1.handle, obj1.params + obj2.params);
        end
        
        function res = uminus(obj1)
            res = B_function(obj1.handle, -obj1.params);
        end
        
        function res = minus(obj1, obj2)
            res = B_function(obj1.handle, obj1.params - obj2.params);
        end
        
        function res = mtimes(obj1, num)
            if (class(obj1) == "double")
                res = mtimes(num, obj1);
                return
            end
            if (class(num) ~= "double") || (class(obj1) ~= "B_function")
                error('Only scalar multiplication is defined!')
            end
            res = B_function(obj1.handle, obj1.params * num);
        end
        
        function res = mrdivide(obj1, num)
            if (class(num) ~= "double") || (class(obj1) ~= "B_function")
                error('Only scalar division is defined!')
            end
            res = B_function(obj1.handle, obj1.params ./ num);
        end
        
        function res = subsref(obj, varargin)
            res = obj.handle(obj.params, varargin{1}.subs{:});
        end
    end
end