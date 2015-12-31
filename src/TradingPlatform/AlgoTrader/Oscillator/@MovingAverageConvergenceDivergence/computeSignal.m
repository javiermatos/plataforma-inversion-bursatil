
function computeSignal(algoTrader)

if ~(algoTrader.Lag > algoTrader.Lead)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    %warning('Lead must be smaller than lag.');
    
else
    
    % Moving Average Convergence/Divergence
    [macd, signal] = algoTrader.bareOutput();
    
    % propertySignal
    propertySignal = zeros(1, length(macd));
    propertySignal(macd>signal) = 1;
    propertySignal(macd<signal) = -1;
    
    % Set Signal property
    algoTrader.Signal = propertySignal;
    
end

end
