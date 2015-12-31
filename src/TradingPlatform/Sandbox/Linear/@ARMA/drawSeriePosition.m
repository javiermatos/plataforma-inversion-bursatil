
function drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)

% Call to parent function
drawSeriePosition@AlgoTrader(algoTrader, axesHandle, setSelector, initIndex, endIndex);

% Parameters
%k = algoTrader.K;
dateTime = algoTrader.DataSerie.DateTime(initIndex:endIndex);

% Prediction
prediction = algoTrader.predict();
%prediction = [NaN(1,k) prediction];
prediction = prediction(initIndex:endIndex);

%draw
hold on;
plot(axesHandle, dateTime, prediction,'b');
hold off;

axis(axesHandle,[dateTime(1) dateTime(end) 1 2]);

end
