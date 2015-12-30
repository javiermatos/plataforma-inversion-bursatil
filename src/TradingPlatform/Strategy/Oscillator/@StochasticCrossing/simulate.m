
function simulate(algoTrader)

samples = algoTrader.Samples;
mode = algoTrader.Mode;
crossingSamples = algoTrader.CrossingSamples;
highSerie = algoTrader.DataSerie.High;
lowSerie = algoTrader.DataSerie.Low;
closeSerie = algoTrader.DataSerie.Close;

stochastic = stoch(highSerie, lowSerie, closeSerie, samples);
movingAverage = movavg(stochastic(samples:end), mode, crossingSamples);
movingAverage = [NaN(1, samples-1) movingAverage];

signal = zeros(1, length(closeSerie));
signal(stochastic>movingAverage) = 1;
signal(stochastic<movingAverage) = -1;

algoTrader.Signal = signal;

end
