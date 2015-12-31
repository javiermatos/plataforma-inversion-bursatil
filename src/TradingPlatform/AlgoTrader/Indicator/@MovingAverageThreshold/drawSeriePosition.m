
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average and threshold
[movingAverage, riseThreshold, fallThreshold] = algoTrader.bareOutput(initIndex, endIndex);

%draw
hold on;
plot(axesHandle, dateTime, movingAverage,'b');
plot(axesHandle, dateTime, riseThreshold,'--m');
plot(axesHandle, dateTime, fallThreshold,'--c');
hold off;

end
