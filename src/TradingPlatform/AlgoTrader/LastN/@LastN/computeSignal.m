
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% nPriceDifference
nPriceDifference = algoTrader.bareOutput();

signal = zeros(1, length(serie));
signal(nPriceDifference>0) = 1;
signal(nPriceDifference<0) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
