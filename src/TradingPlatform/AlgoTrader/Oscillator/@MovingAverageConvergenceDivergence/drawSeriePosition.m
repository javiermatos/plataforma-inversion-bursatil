
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Parameters
mode = algoTrader.Mode;
lead = algoTrader.Lead;
lag = algoTrader.Lag;
serie = algoTrader.DataSerie.Serie(max(initIndex-lag+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
leadMovingAverage = movavg(serie, mode, lead);
lagMovingAverage = movavg(serie, mode, lag);

% Cut to fit the size
leadMovingAverage = leadMovingAverage(end-(endIndex-initIndex):end);
lagMovingAverage = lagMovingAverage(end-(endIndex-initIndex):end);

%draw
hold on;
plot(axesHandle, dateTime, leadMovingAverage,'c');
plot(axesHandle, dateTime, lagMovingAverage,'m');
hold off;

end
