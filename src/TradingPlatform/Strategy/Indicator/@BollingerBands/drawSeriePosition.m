
function drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
k = algoTrader.K;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Bollinger Bands
[movingAverage, upperBand, lowerBand] = bbands(serie, mode, samples, k);

movingAverage = movingAverage(end-(endIndex-initIndex):end);
upperBand = upperBand(end-(endIndex-initIndex):end);
lowerBand = lowerBand(end-(endIndex-initIndex):end);

%draw
hold on;
plot(axesHandle,dateTime,movingAverage,'k');
plot(axesHandle,dateTime,upperBand,'m');
plot(axesHandle,dateTime,lowerBand,'c');
hold off;

end
