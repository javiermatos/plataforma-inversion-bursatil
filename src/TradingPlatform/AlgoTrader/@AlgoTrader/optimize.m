
function varargout = optimize(algoTrader, varargin)

% Default fitness function is built-in fitness which calls profitLoss
fitnessMethodWithArguments = {};

% Default selection function is max
selectionFunction = @max;

% Default optimization method is exhaustive
optimizationMethod = @exhaustive;
optimizationMethodArguments = {};

% Change default if requested in the call
if isa(varargin{1},'function_handle') || iscell(varargin{1})
    
    % First optional parameter is optimization method
    if isa(varargin{1},'function_handle')
        fitnessMethodWithArguments = varargin(1);
    elseif iscell(varargin{1})
        fitnessMethodWithArguments = varargin{1};
    end
    
    % Second optional parameter is selection function
    if isa(varargin{2},'function_handle')
        
        % Objetive is min or max
        selectionFunction = varargin{2};
        
        % Third optional parameter is optimization method
        if isa(varargin{3},'function_handle') || iscell(varargin{3})
            
            if isa(varargin{3},'function_handle')
                optimizationMethod = varargin{3};
                optimizationMethodArguments = {};
            elseif iscell(varargin{3})
                optimizationMethod = varargin{3}{1};
                optimizationMethodArguments = varargin{3}(2:end);
            end
            
            pairs = varargin(4:end);
            
        else
            
            pairs = varargin(3:end);
            
        end
        
    else
        
        pairs = varargin(2:end);
        
    end
    
else
    
    pairs = varargin;
    
end

%optimizationMethod
%optimizationMethodArguments

% Organize input
propertyName = pairs(1:2:end);
propertyDomain = pairs(2:2:end);
propertyDomainSize = cellfun(@length, propertyDomain);

% Call optimization optimizationMethod
bestIndexArray = optimizationMethod ...
        ( ...
            selectionFunction, ...
            @(indexArray) fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray), ...
            propertyDomainSize, ...
            optimizationMethodArguments{:} ...
        );

% Set values
for i = 1:length(propertyName)
    
    subsasgn( ...
        algoTrader, ...
        struct( ...
            'type','.', ...
            'subs',propertyName{i} ...
            ),...
        innerValue(propertyDomain{i}(bestIndexArray(i))) ...
        );
    
end

% Return results if requested
if nargout == 2
    varargout{1} = propertyName;
    varargout{2} = cellfun(@(cell, index) innerValue(cell(index)), ...
        propertyDomain, num2cell(bestIndexArray),'UniformOutput',false);
end

end


function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
