
function [leadMovingAverage, lagMovingAverage] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
mode = algoTrader.Mode;
lead = algoTrader.Lead;
lag = algoTrader.Lag;
serie = algoTrader.DataSerie.Serie(max(initIndex-lag+1,1):endIndex);

% Moving Average
leadMovingAverage = movavg(serie, mode, lead);
lagMovingAverage = movavg(serie, mode, lag);

% Cut to fit the size
leadMovingAverage = leadMovingAverage(end-(endIndex-initIndex):end);
lagMovingAverage = lagMovingAverage(end-(endIndex-initIndex):end);

end
