
function computeSignal(algoTrader)

% Parameters
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;

% Stochastic
stochastic = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(stochastic));
signal(stochastic>riseThreshold) = 1;
signal(stochastic<fallThreshold) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
