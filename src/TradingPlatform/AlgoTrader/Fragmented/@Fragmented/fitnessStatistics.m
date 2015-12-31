
function [minFitness, maxFitness, meanFitness, stdFitness] ...
    = fitnessStatistics(algoTrader, varargin)

% Default fitness function is built-in fitness which calls profitLoss
fitnessMethodWithArguments = {};

% Default selection function is max
selectionFunction = @max;

% Optimization method is exhaustive
optimizationMethod = @exhaustive;

% Change default if requested in the call
if length(varargin) >= 3
    
    if isa(varargin{1},'function_handle')
        fitnessMethodWithArguments = varargin(1);
    elseif iscell(varargin{1})
        fitnessMethodWithArguments = varargin{1};
    end
    
    selectionFunction = varargin{2};
    
    outerPairs = varargin{3};
    innerPairs = varargin{4};
    
else
    
    outerPairs = varargin{1};
    innerPairs = varargin{2};
    
end

%
optimizationSpecs = {};
if ~isempty(fitnessMethodWithArguments)
    optimizationSpecs = {fitnessMethodWithArguments selectionFunction optimizationMethod};
end

% Organize input
outerPropertyName = outerPairs(1:2:end);
outerPropertyDomain = outerPairs(2:2:end);
outerPropertyDomainSize = cellfun(@length, outerPropertyDomain);

% Allocate to store search space
if length(outerPropertyDomainSize) == 1
    searchSpace = zeros(outerPropertyDomainSize,1);
else
    searchSpace = zeros(outerPropertyDomainSize);
end

% Optimize
for i = 1:prod(outerPropertyDomainSize)
    
    % Create a local copy to manipulate
    localAlgoTrader = algoTrader.clone();
    
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
    
    % Call optimization method
    localAlgoTrader.optimize( ...
        optimizationSpecs{:}, ...
        {}, innerPairs ...
        );
    
    % Postfix
    searchSpace = subsasgn( ...
        searchSpace, ...
        substruct('()',num2cell(indexArray)), ...
        localAlgoTrader.fitness(fitnessMethodWithArguments{:}) ...
        );
    
end

fitness = searchSpace(:);

minFitness = min(fitness);
maxFitness = max(fitness);
meanFitness = sum(fitness)/length(fitness);
stdFitness = sqrt(sum((fitness-meanFitness).^2)/length(fitness));
%meanFitness = mean(fitness);
%stdFitness = std(fitness,1);


% Figure
figureHandle = figure;
axesHandle = axes();

% Basic
descriptionItems = cellfun ...
    ( ...
        @(pName, pDomain) {[pName ' (' num2str(length(pDomain)) '), ']}, ...
        outerPropertyName, ...
        outerPropertyDomain ...
    );
descriptionItems{end} = descriptionItems{end}(1:end-2);
description = [descriptionItems{:}];

set(figureHandle,'Name',['Fitness function: ' description]);
set(figureHandle,'NumberTitle','off');
set(figureHandle,'Color',Default.BackgroundColor);

% Axes boxes
set(axesHandle, 'Box', Default.Box);

% Histogram
[n,xout] = hist(fitness, 100);
bar(axesHandle, xout,n,'FaceColor','r','EdgeColor','w','BarWidth',1);

% Information and fixes
xlabel(axesHandle, '\bfPerformance');
ylabel(axesHandle, '\bfNumber of AlgoTrader instances');

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

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
