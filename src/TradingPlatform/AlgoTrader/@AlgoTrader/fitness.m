
function fitness = fitness(algoTrader, methodWithArguments)

if ~exist('methodWithArguments','var')
    
    % Without applying InitialIndex
    %fitness = algoTrader.profitLoss(1, algoTrader.SplitIndex, false);
    
    % Applying InitialIndex
    fitness = algoTrader.profitLoss(algoTrader.InitialIndex, algoTrader.SplitIndex, false);
    
else 
    
    if isa(methodWithArguments,'function_handle')
        method = methodWithArguments;
        methodArguments = {};
    else
        method = methodWithArguments{1};
        methodArguments = methodWithArguments(2:end);
    end
    
    fitness = method( ...
        algoTrader.profitLossSerie(algoTrader.InitialIndex, algoTrader.SplitIndex, false), ...
        methodArguments{:} ...
        );
    
end

end
