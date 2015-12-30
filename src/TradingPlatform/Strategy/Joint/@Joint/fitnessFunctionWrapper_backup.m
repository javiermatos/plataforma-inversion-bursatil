
function fitnessValue = fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray)

% Create instance
%algoTraderInstance = feval(class(algoTrader), algoTrader.DataSerie);
algoTraderInstance = algoTrader.clone();

% Set values
currentIndex = 1;
for i = 1:length(propertyName)
    
    for j = 1:length(propertyName{i})
        
        subsasgn(algoTraderInstance.Set{i}, struct('type','.','subs',propertyName{i}{j}), innerValue(propertyDomain{i}{j}(indexArray(currentIndex))));
        
        currentIndex = currentIndex + 1;
        
    end
    
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
