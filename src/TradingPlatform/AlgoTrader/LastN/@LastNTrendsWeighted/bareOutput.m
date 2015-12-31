
function [nRisingTrends, nFallingTrends] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
weight = algoTrader.Weight;
samples = length(weight);
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

N = length(serie);

risingTrends = serie(1:end-1)<serie(2:end);
nRisingTrends = zeros(1, N);

fallingTrends = serie(1:end-1)>serie(2:end);
nFallingTrends = zeros(1, N);

for i = 1:samples
    nRisingTrends = nRisingTrends + [zeros(1,i) risingTrends(1:end-i+1)*weight(samples-i+1)];
    nFallingTrends = nFallingTrends + [zeros(1,i) fallingTrends(1:end-i+1)*weight(samples-i+1)];
end

% Cut to fit the size
nRisingTrends = nRisingTrends(end-(endIndex-initIndex):end);
nFallingTrends = nFallingTrends(end-(endIndex-initIndex):end);

end
