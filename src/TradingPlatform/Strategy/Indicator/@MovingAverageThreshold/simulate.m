
function simulate(algoTrader)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;
serie = algoTrader.DataSerie.Serie;

% Moving Average
movingAverage = movavg(serie, mode, samples);

% Signal
signal = zeros(1, length(serie));
signal(serie>(movingAverage*(1+riseThreshold))) = 1;
signal(serie<(movingAverage*(1-fallThreshold))) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
