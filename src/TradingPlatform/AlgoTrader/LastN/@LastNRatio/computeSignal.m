
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% risePrice, fallPrice, riseFallRatio, fallRiseRatio
[risePrice, fallPrice, riseFallRatio, fallRiseRatio] = algoTrader.bareOutput();

signal = zeros(1, length(serie));
signal(abs(risePrice./fallPrice)>riseFallRatio) = 1;
signal(abs(fallPrice./risePrice)>fallRiseRatio) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
