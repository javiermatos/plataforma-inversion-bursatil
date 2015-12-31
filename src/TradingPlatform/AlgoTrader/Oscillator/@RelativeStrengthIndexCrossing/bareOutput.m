
function [relativeStrengthIndex, movingAverage] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
samples = algoTrader.Samples;
cMode = algoTrader.CMode;
cSamples = algoTrader.CSamples;
serie = algoTrader.DataSerie.Serie(max(initIndex-(samples+cSamples)+1,1):endIndex);

% Relative Strength Index
relativeStrengthIndex = rsindex(serie, samples);

% Moving Average
relativeStrengthIndexModified = relativeStrengthIndex;
% Only NaN values at first
relativeStrengthIndexModified(isnan(relativeStrengthIndexModified(samples+1:end))) = 50;
movingAverage = movavg(relativeStrengthIndexModified(samples+1:end), cMode, cSamples);
movingAverage = [NaN(1, samples) movingAverage];

% Cut to fit the size
relativeStrengthIndex = relativeStrengthIndex(end-(endIndex-initIndex):end);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

end
