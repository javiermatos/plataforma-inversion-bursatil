
function computeSignal(algoTrader)

% Relative Strength Index and Moving Average
[relativeStrengthIndex, movingAverage] = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(relativeStrengthIndex));
signal(relativeStrengthIndex>movingAverage) = -1;
signal(relativeStrengthIndex<movingAverage) = 1;

algoTrader.Signal = signal;

end
