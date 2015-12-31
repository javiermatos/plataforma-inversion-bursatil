
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% nRisingTrends, nFallingTrendss
[nRisingTrends, nFallingTrends] = algoTrader.bareOutput();

signal = zeros(1, length(serie));
signal(nRisingTrends>nFallingTrends) = 1;
signal(nRisingTrends<nFallingTrends) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
