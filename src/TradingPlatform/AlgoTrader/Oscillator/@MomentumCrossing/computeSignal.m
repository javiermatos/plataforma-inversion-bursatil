
function computeSignal(algoTrader)

% Momentum and moving average
[momentum, movingAverage] = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(momentum));
signal(momentum>movingAverage) = 1;
signal(momentum<movingAverage) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
