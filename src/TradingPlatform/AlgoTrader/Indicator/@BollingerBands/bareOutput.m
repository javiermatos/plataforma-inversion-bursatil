
function [movingAverage, upperBand, lowerBand] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
samples = algoTrader.Samples;
k = algoTrader.K;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

% Bollinger Bands
[movingAverage, upperBand, lowerBand] = bbands(serie, samples, k);

movingAverage = movingAverage(end-(endIndex-initIndex):end);
upperBand = upperBand(end-(endIndex-initIndex):end);
lowerBand = lowerBand(end-(endIndex-initIndex):end);

end
