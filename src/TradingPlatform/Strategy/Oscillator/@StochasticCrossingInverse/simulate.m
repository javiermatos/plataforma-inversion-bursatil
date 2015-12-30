
function simulate(algoTrader)

simulate@StochasticCrossing(algoTrader);
signal = -1*algoTrader.Signal;

% Set Signal property
algoTrader.Signal = signal;

end
