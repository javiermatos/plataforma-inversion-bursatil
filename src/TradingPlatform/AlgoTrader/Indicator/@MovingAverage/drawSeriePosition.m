
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving average
movingAverage = algoTrader.bareOutput(initIndex, endIndex);

%draw
hold on;
plot(axesHandle, dateTime, movingAverage,'b');
hold off;

end
