
function [stochastic, k, d] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
samples = algoTrader.Samples;
mode = algoTrader.Mode;
kSamples = algoTrader.KSamples;
dSamples = algoTrader.DSamples;
highSerie = algoTrader.DataSerie.High(max(initIndex-samples+1-kSamples+1-dSamples+1,1):endIndex);
lowSerie = algoTrader.DataSerie.Low(max(initIndex-samples+1-kSamples+1-dSamples+1,1):endIndex);
closeSerie = algoTrader.DataSerie.Close(max(initIndex-samples+1-kSamples+1-dSamples+1,1):endIndex);

% Stochastic, %K and %D
stochastic = stoch(highSerie, lowSerie, closeSerie, samples);
k = movavg(stochastic, mode, kSamples);
d = movavg(k, mode, dSamples);

% Cut to fit the size
stochastic = stochastic(end-(endIndex-initIndex):end);
k = k(end-(endIndex-initIndex):end);
d = d(end-(endIndex-initIndex):end);

end
