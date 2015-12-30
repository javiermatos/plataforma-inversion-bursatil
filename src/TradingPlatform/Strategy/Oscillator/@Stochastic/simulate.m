
function simulate(algoTrader)

samples = algoTrader.Samples;
highThreshold = algoTrader.HighThreshold;
lowThreshold = algoTrader.LowThreshold;
highSerie = algoTrader.DataSerie.High;
lowSerie = algoTrader.DataSerie.Low;
closeSerie = algoTrader.DataSerie.Close;

stochastic = stoch(highSerie, lowSerie, closeSerie, samples);

signal = zeros(1, length(closeSerie));
signal(stochastic>highThreshold) = 1;
signal(stochastic<lowThreshold) = -1;

algoTrader.Signal = signal;

end
