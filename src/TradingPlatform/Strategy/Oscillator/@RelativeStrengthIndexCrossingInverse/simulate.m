
function simulate(algoTrader)

simulate@RelativeStrengthIndexCrossing(algoTrader);
signal = -1*algoTrader.Signal;

% Set Signal property
algoTrader.Signal = signal;

end
