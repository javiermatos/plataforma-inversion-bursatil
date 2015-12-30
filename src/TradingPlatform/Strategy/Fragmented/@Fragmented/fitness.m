
function fitness = fitness(algoTrader, methodWithArguments)

if ~exist('methodWithArguments','var')
    
    fitness = algoTrader.profitLoss(algoTrader.InitialIndex, [], false);
    
else 
    
    if isa(methodWithArguments,'function_handle')
        method = methodWithArguments;
        methodArguments = {};
    else
        method = methodWithArguments{1};
        methodArguments = methodWithArguments(2:end);
    end
    
    fitness = method( ...
        algoTrader.profitLossSerie(algoTrader.InitialIndex, [], false), ...
        methodArguments{:} ...
        );
    
end

end
