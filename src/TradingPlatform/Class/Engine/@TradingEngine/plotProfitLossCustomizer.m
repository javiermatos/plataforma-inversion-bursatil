
function plotProfitLossCustomizer(te, startIndex, endIndex, axesHandle, varargin)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

hold on;
plot(axesHandle, ...
    fts.Date(startIndex:endIndex), ...
    te.ProfitLossSerie(startIndex:endIndex), ...
    Default.ProfitLossLineSpec, ...
    'LineWidth', Default.ProfitLossLineWidth ...
    );
hold off;

title(axesHandle, '\bfProfit/Loss serie');
%legend(axesHandle, 'Profit/Loss');
xlabel(axesHandle, '\bfDate');
ylabel(axesHandle, '\bfQuantity');
xlim(axesHandle, [fts.Date(startIndex) fts.Date(endIndex)]);

end
