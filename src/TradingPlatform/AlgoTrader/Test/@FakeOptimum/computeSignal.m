
function computeSignal(algoTrader)

% Parameters
foresee = algoTrader.Foresee;
serie = algoTrader.DataSerie.Serie;

signal = [sign(serie(foresee+1:end)-serie(1:end-foresee)) zeros(1, foresee)];

% Set Signal property
algoTrader.Signal = signal;

end
