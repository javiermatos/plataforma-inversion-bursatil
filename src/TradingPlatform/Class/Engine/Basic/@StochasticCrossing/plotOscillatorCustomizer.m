
function plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

[stochastic, movingAverage] = stoch(fts.High, fts.Low, fts.Close, te.StochasticSamples, te.Mode, te.MovingAverageSamples);


hold on;
plot(axesHandle, ...
    fts.Date(startIndex:endIndex), ...
    stochastic, ...
    'b', ...
    'LineWidth', 1 ...
    );
plot(axesHandle, ...
    fts.Date(startIndex:endIndex), ...
    movingAverage, ...
    '--g', ...
    'LineWidth', 1 ...
    );
plot(axesHandle, ...
    [fts.Date(startIndex), fts.Date(endIndex)], ...
    [te.HighThreshold, te.HighThreshold], ...
    'r', ...
    'LineWidth', 2 ...
    );
plot(axesHandle, ...
    [fts.Date(startIndex), fts.Date(endIndex)], ...
    [te.LowThreshold, te.LowThreshold], ...
    'r', ...
    'LineWidth', 2 ...
    );
hold off;

title(axesHandle, '\bfStochastic');
legend(axesHandle, {'Stochastic','Moving Average'});
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [fts.Date(startIndex) fts.Date(endIndex)]);

end