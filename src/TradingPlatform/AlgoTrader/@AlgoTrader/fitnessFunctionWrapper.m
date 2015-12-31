
function performance = fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray)

% Create instance (CLONE, SLOW)
% With clone method we can use the Trading Platform with multiple
% processors, but the computing time is slower
algoTraderInstance = algoTrader.clone();

% Create instance (DO NOT CLONE, FAST)
% Without using the clone method the computation speed is increased
%algoTraderInstance = algoTrader;

% Set values
for i = 1:length(propertyName)
    
    subsasgn( ...
        algoTraderInstance, ...
        struct( ...
            'type','.', ...
            'subs',propertyName{i} ...
            ), ...
        innerValue(propertyDomain{i}(indexArray(i))) ...
        );
    
end

% Compute fitness
performance = algoTraderInstance.fitness(fitnessMethodWithArguments{:});

end

function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
