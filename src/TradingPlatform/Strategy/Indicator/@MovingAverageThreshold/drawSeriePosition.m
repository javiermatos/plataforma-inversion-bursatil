
function drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
movingAverage = movavg(serie, mode, samples);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

% Threshold bands
upperBand = movingAverage*(1+riseThreshold);
lowerBand = movingAverage*(1-fallThreshold);

%draw
hold on;
plot(axesHandle, dateTime, movingAverage,'k');
plot(axesHandle, dateTime, upperBand,'--m');
plot(axesHandle, dateTime, lowerBand,'--c');
hold off;

end
