classdef B_function
    % B_FUNCTION Description of a B-field with a handle to evaluation
    % function 
    
    properties
        eval function_handle
    end
    
    methods
        function obj = B_function(handle)
            %B_FUNCTION Construct an instance of this class
            obj.eval = handle;
        end
        
        function res = plus(obj1,obj2)
            res = B_function(@(varargin) obj1.eval(varargin{:}) + obj2.eval(varargin{:}));
        end
        
        function res = uminus(obj1)
            res = B_function(@(varargin) -obj1.eval(varargin{:}));
        end
        
        function res = minus(obj1, obj2)
            res = B_function(@(varargin) obj1.eval(varargin{:}) - obj2.eval(varargin{:}));
        end
        
        function res = mtimes(obj1, num)
            if (class(obj1) == "double")
                res = mtimes(num, obj1);
                return
            end
            if (class(num) ~= "double") || (class(obj1) ~= "B_function")
                error('Only scalar multiplication is defined!')
            end
            res = B_function(@(varargin) obj1.eval(varargin{:})*num);
        end
        
        function res = subsref(obj, varargin)
            res = obj.eval(varargin{1}.subs{:});
        end
    end
end

