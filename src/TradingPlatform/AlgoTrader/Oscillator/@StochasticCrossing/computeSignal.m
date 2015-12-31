
function computeSignal(algoTrader)

% Stochastig, %K and %D
[stochastic, k, d] = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(k));
signal(k>d) = 1;
signal(k<d) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
