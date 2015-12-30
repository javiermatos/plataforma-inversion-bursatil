
function optimize(algoTrader, varargin)

if isa(varargin{1},'function_handle') ||  iscell(varargin{1})
    
    % First optional parameter is optimization method
    if isa(varargin{1},'function_handle')
        method = varargin{1};
        methodArguments = {};
    elseif iscell(varargin{1})
        method = varargin{1};
        methodArguments = varargin{1}(2:end);
    end
    
    % Second optional parameter is fitness method
    if isa(varargin{2},'function_handle')
        fitnessMethodWithArguments = varargin(2);
        pairs = varargin(3:end);
    elseif iscell(varargin{2})
        fitnessMethodWithArguments = varargin{2};
        pairs = varargin(3:end);
    else
        fitnessMethodWithArguments = {};
        pairs = varargin(2:end);
    end
    
else
    
    % Default optimization method is exhaustive
    method = @exhaustive;
    methodArguments = {};
    
    % Default fitness method is built-in fitness
    fitnessMethodWithArguments = {};
    
    pairs = varargin;    
    
end

% Organize input
propertyName = pairs(1:2:end);
propertyDomain = pairs(2:2:end);
propertyDomainSize = cellfun(@length, propertyDomain);

% Call optimization method
bestIndexArray = method ...
        ( ...
            @(indexArray) fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray), ...
            propertyDomainSize, ...
            methodArguments{:} ...
        );

% Set values
for i = 1:length(propertyDomain)
    
    subsasgn(algoTrader, struct('type','.','subs',propertyName{i}), innerValue(propertyDomain{i}(bestIndexArray(i))));
    
end

end

function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
