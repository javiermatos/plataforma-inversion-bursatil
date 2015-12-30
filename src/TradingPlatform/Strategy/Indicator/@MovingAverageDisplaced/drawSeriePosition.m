
function drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, initIndex, endIndex, applySplit)

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
displacement = algoTrader.Displacement;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples-displacement+1,1):endIndex);
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
movingAverage = movavg(serie, mode, samples);
movingAverage = movingAverage(max(end-(endIndex-initIndex)-displacement,1):end-displacement);
movingAverage = [ NaN(1,(endIndex-initIndex+1)-length(movingAverage)) movingAverage ];

%draw
hold on;
plot(axesHandle, dateTime, movingAverage,'b');
hold off;

end
