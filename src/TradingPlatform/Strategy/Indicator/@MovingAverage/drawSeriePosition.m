
function drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, initIndex, endIndex, applySplit);

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
movingAverage = movavg(serie, mode, samples);
movingAverage = movingAverage(end-(endIndex-initIndex):end);

%draw
hold on;
plot(axesHandle, dateTime, movingAverage,'b');
hold off;

end
