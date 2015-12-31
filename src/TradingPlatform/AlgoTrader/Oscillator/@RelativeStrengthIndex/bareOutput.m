
function relativeStrengthIndex = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

% Relative Strength Index
relativeStrengthIndex = rsindex(serie, samples);
relativeStrengthIndex = relativeStrengthIndex(end-(endIndex-initIndex):end);

end
