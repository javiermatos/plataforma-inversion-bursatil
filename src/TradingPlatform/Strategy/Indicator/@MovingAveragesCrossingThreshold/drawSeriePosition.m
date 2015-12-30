
function drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Parameters
mode = algoTrader.Mode;
lead = algoTrader.Lead;
lag = algoTrader.Lag;
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;
serie = algoTrader.DataSerie.Serie(max(initIndex-lead+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
leadMovingAverage = movavg(serie, mode, lead);
leadMovingAverage = leadMovingAverage(end-(endIndex-initIndex):end);
lagMovingAverage = movavg(serie, mode, lag);
lagMovingAverage = lagMovingAverage(end-(endIndex-initIndex):end);

% Threshold bands
upperBand = lagMovingAverage*(1+riseThreshold);
lowerBand = lagMovingAverage*(1-fallThreshold);

%draw
hold on;
plot(axesHandle, dateTime, leadMovingAverage,'r');
plot(axesHandle, dateTime, lagMovingAverage,'b');
plot(axesHandle, dateTime, upperBand,'--m');
plot(axesHandle, dateTime, lowerBand,'--c');
hold off;

end
