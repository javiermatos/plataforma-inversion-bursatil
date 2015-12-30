
function simulate(algoTrader)

samples = algoTrader.Samples;
highThreshold = algoTrader.HighThreshold;
lowThreshold = algoTrader.LowThreshold;
serie = algoTrader.DataSerie.Serie;

relativeStrengthIndex = rsindex(serie, samples);

signal = zeros(1, length(serie));
signal(relativeStrengthIndex>highThreshold) = -1;
signal(relativeStrengthIndex<lowThreshold) = 1;

algoTrader.Signal = signal;

end
