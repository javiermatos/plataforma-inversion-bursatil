
function simulate(algoTrader)

simulate@BollingerBands(algoTrader);
signal = -1*algoTrader.Signal;

% Set Signal property
algoTrader.Signal = signal;

end
