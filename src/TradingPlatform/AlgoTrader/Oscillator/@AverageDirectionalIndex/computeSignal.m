
function computeSignal(algoTrader)

% AverageDirectionalIndex
[ ...
    plusDirectionalMovement, ...
    minusDirectionalMovement, ...
    directionalMovementIndex, ...
    averageDirectionalIndex ...
] = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(plusDirectionalMovement));
signal(plusDirectionalMovement>minusDirectionalMovement) = 1;
signal(plusDirectionalMovement<minusDirectionalMovement) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
