
function optimizeSelection(algoTrader, varargin)

% Default fitness function is built-in fitness which calls profitLoss
fitnessMethodWithArguments = {};

% Default selection function is max
selectionFunction = @max;

% Default optimization method is exhaustive
optimizationMethod = @exhaustive;
optimizationMethodArguments = {};

% Change default if requested in the call
if nargin > 1 && (isa(varargin{1},'function_handle') || iscell(varargin{1}))
    
    % First optional parameter is optimization method
    if isa(varargin{1},'function_handle')
        fitnessMethodWithArguments = varargin(1);
    elseif iscell(varargin{1})
        fitnessMethodWithArguments = varargin{1};
    end
    
    % Second optional parameter is selection function
    if nargin > 2 && (isa(varargin{2},'function_handle'))
        
        % Objetive is min or max
        selectionFunction = varargin{2};
        
        % Third optional parameter is optimization method
        if nargin > 3 && (isa(varargin{3},'function_handle') || iscell(varargin{3}))
            
            if isa(varargin{3},'function_handle')
                optimizationMethod = varargin{3};
                optimizationMethodArguments = {};
            elseif iscell(varargin{3})
                optimizationMethod = varargin{3}{1};
                optimizationMethodArguments = varargin{3}(2:end);
            end
            
        end
        
    end
    
end

% Call optimization optimizationMethod
bestIndexArray = optimizationMethod ...
        ( ...
            selectionFunction, ...
            @(indexArray) selectionFitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, indexArray), ...
            2*ones(1,length(algoTrader.Selection)), ...
            optimizationMethodArguments{:} ...
        );

% Set values
algoTrader.Selection = (bestIndexArray-1)';

end


function fitnessValue = selectionFitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, indexArray)

% Create instance
algoTraderInstance = algoTrader.clone();

% Set values
algoTraderInstance.Selection = (indexArray-1)';

% Compute fitness
fitnessValue = algoTraderInstance.fitness(fitnessMethodWithArguments{:});

end
