
function [momentum, movingAverage] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
delay = algoTrader.Delay;
mode = algoTrader.Mode;
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-delay-samples+1,1):endIndex);

% Momentum
momentum = [NaN(1, delay) serie(delay+1:end)-serie(1:end-delay)];
movingAverage = movavg(momentum, mode, samples);

% Cut to fit the size
momentum = momentum(end-(endIndex-initIndex):end);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

end
