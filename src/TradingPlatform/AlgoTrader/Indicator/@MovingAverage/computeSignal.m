
function computeSignal(algoTrader)

% serie
serie = algoTrader.DataSerie.Serie;

% Moving average
movingAverage = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(serie));
signal(serie>movingAverage) = 1;
signal(serie<movingAverage) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
