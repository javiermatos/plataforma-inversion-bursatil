
function [fastMovingAverage, middleMovingAverage, slowMovingAverage] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
mode = algoTrader.Mode;
fast = algoTrader.Fast;
middle = algoTrader.Middle;
slow = algoTrader.Slow;
serie = algoTrader.DataSerie.Serie(max(initIndex-slow+1,1):endIndex);

% Moving Average
fastMovingAverage = movavg(serie, mode, fast);
middleMovingAverage = movavg(serie, mode, middle);
slowMovingAverage = movavg(serie, mode, slow);

% Cut to fit the size
fastMovingAverage = fastMovingAverage(end-(endIndex-initIndex):end);
middleMovingAverage = middleMovingAverage(end-(endIndex-initIndex):end);
slowMovingAverage = slowMovingAverage(end-(endIndex-initIndex):end);

end
