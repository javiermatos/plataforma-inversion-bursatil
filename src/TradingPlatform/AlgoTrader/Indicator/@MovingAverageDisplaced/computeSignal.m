
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% Moving Average
movingAverageDisplaced = algoTrader.bareOutput();

% Signal
signal = zeros(1, length(serie));
signal(serie>movingAverageDisplaced) = 1;    % Buy signal
signal(serie<movingAverageDisplaced) = -1;   % Sell signal

% Set Signal property
algoTrader.Signal = signal;

end
