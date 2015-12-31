
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average
[leadMovingAverage, lagMovingAverage] = algoTrader.bareOutput(initIndex, endIndex);

%draw
hold on;
plot(axesHandle, dateTime, leadMovingAverage,'m');
plot(axesHandle, dateTime, lagMovingAverage,'b');
hold off;

end
