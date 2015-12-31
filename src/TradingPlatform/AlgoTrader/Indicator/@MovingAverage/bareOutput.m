
function movingAverage = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

% Moving Average
movingAverage = movavg(serie, mode, samples);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

end
