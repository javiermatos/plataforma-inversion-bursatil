
function optimize(algoTrader, varargin)

% Default fitness function is built-in fitness which calls profitLoss
fitnessMethodWithArguments = {};

% Default selection function is max
selectionFunction = @max;

% Default optimization method is exhaustive
optimizationMethodWithArguments = @exhaustive;

% Change default if requested in the call
if length(varargin) >= 3 && (isa(varargin{1},'function_handle') || iscell(varargin{1}))
    
    % First optional parameter is optimization method
    if isa(varargin{1},'function_handle')
        fitnessMethodWithArguments = varargin(1);
    elseif iscell(varargin{1})
        fitnessMethodWithArguments = varargin{1};
    end
    
    % Second optional parameter is selection function
    if length(varargin) >= 4 && isa(varargin{2},'function_handle')
        
        % Objetive is min or max
        selectionFunction = varargin{2};
        
        % Third optional parameter is optimization method
        if length(varargin) >= 5 && (isa(varargin{3},'function_handle') || iscell(varargin{3}))
            
            optimizationMethodWithArguments = varargin{3};
            
            outerPairs = varargin{4};
            innerPairs = varargin{5};
            
        else
            
            outerPairs = varargin{3};
            innerPairs = varargin{4};
            
        end
        
    else
        
        outerPairs = varargin{2};
        innerPairs = varargin{3};
        
    end
    
else
    
    outerPairs = varargin{1};
    innerPairs = varargin{2};
    
end


if isempty(outerPairs)
    
    % Este bucle NO SE PUEDE HACER EN PARALELO. Sucede que el método
    % optimize actualiza el valor de los parámetros del objeto, pero no
    % devuelve ningún tipo de resultado. En consecuencia, las instancias de
    % MATLAB computan el resultado y actualizan su propia copia local del
    % objeto, pero no informan de los cambios en el servidor.

    for i = 1:length(algoTrader.Fragment)
        
        algoTrader.Fragment(i).optimize( ...
            fitnessMethodWithArguments, ...
            selectionFunction, ...
            optimizationMethodWithArguments ,...
            innerPairs{:} ...
            );
        
%         [propertyName, propertyValue] = algoTrader.Fragment(i).optimize( ...
%             fitnessMethodWithArguments, ...
%             selectionFunction, ...
%             optimizationMethodWithArguments ,...
%             innerPairs{:} ...
%             );
%         
%         % Assign
%         for j = 1:length(propertyName)
%             
%             subsasgn( ...
%                 algoTrader.Fragment(i), ...
%                 struct( ...
%                     'type','.', ...
%                     'subs',propertyName{j} ...
%                     ),...
%                 innerValue(propertyValue{j}) ...
%                 );
%             
%         end
        
    end
    
else

    % Organize input
    outerPropertyName = outerPairs(1:2:end);
    outerPropertyDomain = outerPairs(2:2:end);
    outerPropertyDomainSize = cellfun(@length, outerPropertyDomain);

    % Initialize bestFitness and objectiveMaximize flag
    if strcmp(func2str(@max),func2str(selectionFunction))
        objectiveMaximize = true;
        bestFitness = -Inf;
    else
        objectiveMaximize = false;
        bestFitness = Inf;
    end

    % Optimize
    for i = 1:prod(outerPropertyDomainSize)

        % Create a local copy to manipulate
        localAlgoTrader = algoTrader.clone();
        %localAlgoTrader = algoTrader;

        % Indexes for outer values
        indexArray = index2indexArray(outerPropertyDomainSize,i);

        % Assign
        for j = 1:length(outerPropertyName)

            subsasgn( ...
                localAlgoTrader, ...
                struct( ...
                    'type','.', ...
                    'subs',outerPropertyName{j} ...
                    ),...
                innerValue(outerPropertyDomain{j}(indexArray(j))) ...
                );

        end

        % Inner optimization
        localAlgoTrader.optimize( ...
            fitnessMethodWithArguments, ...
            selectionFunction, ...
            optimizationMethodWithArguments ,...
            {}, ...
            innerPairs ...
            );

        % Check for the fitness
        currentFitness = localAlgoTrader.fitness(fitnessMethodWithArguments{:});

        if objectiveMaximize && bestFitness < currentFitness

            bestAlgoTrader = localAlgoTrader.clone();
            bestFitness = currentFitness;

        elseif ~objectiveMaximize && bestFitness > currentFitness

            bestAlgoTrader = localAlgoTrader.clone();
            bestFitness = currentFitness;

        end

    end

    % Copy values from bestAlgoTrader
    % Non-dependent properties
    metaClass = metaclass(algoTrader);

    metaClassProperties = findobj([metaClass.Properties{:}],'Dependent',false);

    N = length(metaClassProperties);
    nonDependentProperties = cell(N, 1);
    for i = 1:N
        nonDependentProperties{i} = metaClassProperties(i).Name;
    end

    % Excluded properties
    excludedProperties = {'DataSerie' 'InnerAlgoTrader' 'Fragment'};

    % Included properties
    includedProperties = nonDependentProperties(~ismember(nonDependentProperties, excludedProperties));

    % Copy included properties
    for i = 1:length(includedProperties)

        subsasgn( ...
            algoTrader, ...
            struct( ...
                'type','.', ...
                'subs',includedProperties{i} ...
                ), ...
            subsref( ...
                bestAlgoTrader, ...
                struct( ...
                    'type','.', ...
                    'subs',includedProperties{i} ...
                    ) ...
                ) ...
            );

    end

    % Reset algoTrader fragments
    algoTrader.resetFragment();

    % Copy fragments
    N = length(bestAlgoTrader.Fragment);
    algoTrader.Fragment = algoTrader.InnerAlgoTrader.empty(0, N);
    for i = 1:N

        algoTrader.Fragment(i) = bestAlgoTrader.Fragment(i).clone();

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


function indexArray = index2indexArray(searchSpaceSize, n)

% Initial correction
n = n-1;

base = cumprod([1 searchSpaceSize(1:end-1)]);

N = length(searchSpaceSize);

indexArray = zeros(1, N);

for i = N:-1:1
    
    idiv = floor(n/base(i));
    n = n - idiv*base(i);
    
    indexArray(i) = idiv;
    
end

% Final correction
indexArray = indexArray+1;

end
