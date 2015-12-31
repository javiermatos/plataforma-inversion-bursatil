
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% Bollinger Bands
[~, upperBand, lowerBand] = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(serie));
signal(serie>upperBand) = -1;
signal(serie<lowerBand) = 1;

% Set Signal property
algoTrader.Signal = signal;

end
