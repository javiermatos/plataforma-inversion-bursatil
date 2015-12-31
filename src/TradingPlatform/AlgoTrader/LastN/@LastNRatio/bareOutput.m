
function [risePrice, fallPrice, riseFallRatio, fallRiseRatio] ...
    = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

N = length(serie);

risePrice = zeros(1, N);
riseDiffPrice = diff(serie);
riseDiffPrice(riseDiffPrice < 0) = 0;

fallPrice = zeros(1, N);
fallDiffPrice = diff(serie);
fallDiffPrice(fallDiffPrice > 0) = 0;

for i = 1:samples
    risePrice = risePrice + [zeros(1,i) riseDiffPrice(1:end-i+1)];
    fallPrice = fallPrice + [zeros(1,i) fallDiffPrice(1:end-i+1)];
end

% Cut to fit the size and fix
risePrice = risePrice(end-(endIndex-initIndex):end);
fallPrice = fallPrice(end-(endIndex-initIndex):end);

riseFallRatio = algoTrader.RiseFallRatio;
fallRiseRatio = algoTrader.FallRiseRatio;

end
