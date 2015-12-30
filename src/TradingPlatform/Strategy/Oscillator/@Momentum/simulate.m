
function simulate(algoTrader)

% Parameters
delay = algoTrader.Delay;
serie = algoTrader.DataSerie.Serie;

% Momentum
momentum = [NaN(1, delay) serie(delay+1:end)-serie(1:end-delay)];

% Signal
signal = zeros(1, length(serie));
signal(momentum>0) = 1;
signal(momentum<0) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
