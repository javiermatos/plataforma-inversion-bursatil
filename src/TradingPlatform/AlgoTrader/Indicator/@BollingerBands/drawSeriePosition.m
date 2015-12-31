
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Bollinger Bands
[movingAverage, upperBand, lowerBand] = algoTrader.bareOutput(initIndex, endIndex);

%draw
hold on;
plot(axesHandle,dateTime,movingAverage,'b');
plot(axesHandle,dateTime,upperBand,'m');
plot(axesHandle,dateTime,lowerBand,'c');
hold off;

end
