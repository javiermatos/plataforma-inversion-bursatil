
function plotSignalCustomizer(te, startIndex, endIndex, axesHandle, varargin)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

hold on;
plot(axesHandle, ...
    fts.Date(startIndex:endIndex), ...
    te.Signal(startIndex:endIndex), ...
    Default.SignalLineSpec, ...
    'LineWidth', Default.SignalLineWidth ...
    );
hold off;

title(axesHandle, '\bfSignal');
%legend(axesHandle, 'Signal');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfPosition');
xlim(axesHandle, [fts.Date(startIndex) fts.Date(endIndex)]);

end
