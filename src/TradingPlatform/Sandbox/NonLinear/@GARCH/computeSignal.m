
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% Prediction
prediction = algoTrader.predict();

% Compute signal
signal = sign(prediction-serie);

% Set Signal
algoTrader.Signal = signal;

end
