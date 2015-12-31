
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Moving Average and treshold bands
[leadMovingAverage, lagMovingAverage, riseThreshold, fallThreshold] = algoTrader.bareOutput(initIndex, endIndex);

%draw
hold on;
plot(axesHandle, dateTime, leadMovingAverage,'y');%'Color',[255 165 0]/255);
plot(axesHandle, dateTime, lagMovingAverage,'b');
plot(axesHandle, dateTime, riseThreshold,'--m');
plot(axesHandle, dateTime, fallThreshold,'--c');
hold off;

end
