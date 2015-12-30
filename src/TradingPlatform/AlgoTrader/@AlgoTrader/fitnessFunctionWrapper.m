
function fitnessValue = fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray)

% Create instance
%algoTraderInstance = feval(class(algoTrader), algoTrader.DataSerie);
algoTraderInstance = algoTrader.clone();

% Set values
for i = 1:length(propertyName)
    
    subsasgn(algoTraderInstance, struct('type','.','subs',propertyName{i}), innerValue(propertyDomain{i}(indexArray(i))));
    
end

% Compute fitness
fitnessValue = algoTraderInstance.fitness(fitnessMethodWithArguments{:});

end

function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
