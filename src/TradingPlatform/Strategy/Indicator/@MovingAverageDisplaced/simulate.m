
function simulate(algoTrader)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
displacement = algoTrader.Displacement;
serie = algoTrader.DataSerie.Serie;

% Moving Average
movingAverage = movavg(serie, mode, samples);
movingAverage = [ NaN(1,displacement) movingAverage(1:end-displacement) ];

% Signal
signal = zeros(1, length(serie));
signal(serie>movingAverage) = 1;    % Buy signal
signal(serie<movingAverage) = -1;   % Sell signal

% Set Signal property
algoTrader.Signal = signal;

end
