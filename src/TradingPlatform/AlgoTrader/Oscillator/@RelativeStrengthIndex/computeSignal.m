
function computeSignal(algoTrader)

% Parameters
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;

% Relative Strength Index
relativeStrengthIndex = algoTrader.bareOutput();

signal = zeros(1, length(relativeStrengthIndex));
signal(relativeStrengthIndex>riseThreshold) = -1;
signal(relativeStrengthIndex<fallThreshold) = 1;

algoTrader.Signal = signal;

end
