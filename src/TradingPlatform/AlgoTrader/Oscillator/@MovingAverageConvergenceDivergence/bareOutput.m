
function [macd, signal, histogram, leadMovingAverage, lagMovingAverage] ...
    = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
mode = algoTrader.Mode;
lead = algoTrader.Lead;
lag = algoTrader.Lag;
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-(lag-1+samples-1),1):endIndex);

% lead lag moving average
leadMovingAverage = movavg(serie, mode, lead);
lagMovingAverage = movavg(serie, mode, lag);

% macd
macd = leadMovingAverage-lagMovingAverage;

% signal
signal = movavg(macd(lag:end), mode, samples);
signal = [NaN(1,lag-1) signal];

% Cut to fit the size
leadMovingAverage = leadMovingAverage(end-(endIndex-initIndex):end);
lagMovingAverage = lagMovingAverage(end-(endIndex-initIndex):end);
macd = macd(end-(endIndex-initIndex):end);
signal = signal(end-(endIndex-initIndex):end);

% histogram
histogram = macd-signal;

end
