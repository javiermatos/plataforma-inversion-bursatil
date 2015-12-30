
function simulate(algoTrader)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
k = algoTrader.K;
serie = algoTrader.DataSerie.Serie;

% Bollinger Bands
[~, upperBand, lowerBand] = bbands(serie, mode, samples, k);

% Signal
signal = zeros(1, length(serie));
signal(serie>upperBand) = -1;
signal(serie<lowerBand) = 1;

% Set Signal property
algoTrader.Signal = signal;

end
