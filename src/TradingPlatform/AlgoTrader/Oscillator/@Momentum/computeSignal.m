
function computeSignal(algoTrader)

% Momentum
momentum = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(momentum));
signal(momentum>0) = 1;
signal(momentum<0) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
