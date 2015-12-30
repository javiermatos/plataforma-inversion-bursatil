
function simulate(algoTrader)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie;

% Moving Average
movingAverage = movavg(serie, mode, samples);

% Signal
signal = zeros(1, length(serie));
signal(serie>movingAverage) = 1;
signal(serie<movingAverage) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
