
function nPriceDifference = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
weight = algoTrader.Weight;
samples = length(weight);
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

diffSerie = diff(serie);
nPriceDifference = zeros(1, length(serie));

for i = 1:samples
    nPriceDifference = nPriceDifference + [zeros(1,i) diffSerie(1:end-i+1)*weight(samples-i+1)];
end

% Cut to fit the size
nPriceDifference = nPriceDifference(end-(endIndex-initIndex):end);

end
