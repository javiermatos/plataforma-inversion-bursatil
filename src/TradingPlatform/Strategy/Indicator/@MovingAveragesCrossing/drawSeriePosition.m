
function drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Parameters
mode = algoTrader.Mode;
lead = algoTrader.Lead;
lag = algoTrader.Lag;
serie = algoTrader.DataSerie.Serie(max(initIndex-lag+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
leadMovingAverage = movavg(serie, mode, lead);
leadMovingAverage = leadMovingAverage(end-(endIndex-initIndex):end);
lagMovingAverage = movavg(serie, mode, lag);
lagMovingAverage = lagMovingAverage(end-(endIndex-initIndex):end);

%draw
hold on;
plot(axesHandle, dateTime, leadMovingAverage,'c');
plot(axesHandle, dateTime, lagMovingAverage,'m');
hold off;

end
