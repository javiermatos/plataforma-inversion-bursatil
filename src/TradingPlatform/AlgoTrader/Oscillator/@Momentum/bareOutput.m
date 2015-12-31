
function momentum = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
delay = algoTrader.Delay;
serie = algoTrader.DataSerie.Serie(max(initIndex-delay,1):endIndex);

% Momentum
momentum = [NaN(1, delay) serie(delay+1:end)-serie(1:end-delay)];
momentum = momentum(end-(endIndex-initIndex):end);

end
