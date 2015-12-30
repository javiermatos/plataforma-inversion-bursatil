
function plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)

fts = te.FinancialTimeSerie;

hold on;
plot(axesHandle, ...
    [fts.Date(startIndex) fts.Date(endIndex)], ...
    [0 0], ...
    Default.OscillatorLineSpec, ...
    'LineWidth', Default.OscillatorLineWidth ...
    );
hold off;

title(axesHandle, '\bfOscillator');
legend(axesHandle, 'Oscillator');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfValue');
xlim(axesHandle, [fts.Date(startIndex) fts.Date(endIndex)]);

end
