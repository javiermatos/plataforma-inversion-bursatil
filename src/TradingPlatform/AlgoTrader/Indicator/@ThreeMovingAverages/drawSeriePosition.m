
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
[fastMovingAverage, middleMovingAverage, slowMovingAverage] = algoTrader.bareOutput(initIndex, endIndex);

%draw
hold on;
plot(axesHandle, dateTime, fastMovingAverage,'m');
plot(axesHandle, dateTime, middleMovingAverage,'y');
plot(axesHandle, dateTime, slowMovingAverage,'c');
hold off;

end
