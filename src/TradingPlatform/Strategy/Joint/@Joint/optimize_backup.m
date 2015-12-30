
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
N = length(algoTrader.Set);
propertyName = cell(1,N);
propertyDomain = cell(1,N);
% propertyIndex = {};
for i = 1:length(pairs)/2
    
    index = pairs{2*i-1};
    
    for j = 1:length(varargin{2*i})/2
        
        name = varargin{2*i}{2*j-1};
        
        if ~ismember(name, propertyName{index})
            
            propertyName{index} = [propertyName{index} {name}];
            
            domain = varargin{2*i}{2*j};
            propertyDomain{index} = [propertyDomain{index} {domain}];
            
        end
        
    end
    
%     for j = 1:length(varargin{2*i})/2
%         propertyIndex = [propertyIndex {{index j}}];
%     end
    
end
propertyDomainSize = cellfun(@length, [propertyDomain{:}]);

% Call optimization method
bestIndexArray = method ...
        ( ...
            @(indexArray) fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray), ...
            propertyDomainSize, ...
            methodArguments{:} ...
        );

% Set values
currentIndex = 1;
for i = 1:length(propertyName)
    
    for j = 1:length(propertyName{i})
        
        subsasgn(algoTrader.Set{i}, struct('type','.','subs',propertyName{i}{j}), innerValue(propertyDomain{i}{j}(bestIndexArray(currentIndex))));
        
        currentIndex = currentIndex + 1;
        
    end
    
end

end

function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
