
function simulate(algoTrader)

samples = algoTrader.Samples;
mode = algoTrader.Mode;
crossingSamples = algoTrader.CrossingSamples;
serie = algoTrader.DataSerie.Serie;

relativeStrengthIndex = rsindex(serie, samples);

% Unsafe
% movingAverage = movavg(relativeStrengthIndex(samples+1:end), mode, crossingSamples);

% Safe (avoid NaN returned by rsindex)
relativeStrengthIndexModified = relativeStrengthIndex;
relativeStrengthIndexModified(isnan(relativeStrengthIndexModified)) = 50;
movingAverage = movavg(relativeStrengthIndexModified(samples+1:end), mode, crossingSamples);

% Correct length
movingAverage = [NaN(1, samples) movingAverage];

signal = zeros(1, length(serie));
signal(relativeStrengthIndex>movingAverage) = -1;
signal(relativeStrengthIndex<movingAverage) = 1;

algoTrader.Signal = signal;

end
