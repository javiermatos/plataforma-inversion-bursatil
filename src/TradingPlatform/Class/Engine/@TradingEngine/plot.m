
function fig = plot(te, startRange, endRange, fun)

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = te.FinancialTimeSerie.Length; end

% fun
if ~exist('fun','var'); fun = @(x) x; end

% Description
description = [ ...
    class(te), ...
    ' | Fitness = ', num2str(te.Fitness), ...
    ' | Profit/Loss = ', num2str(te.computeProfitLoss('test')) ...
    ];

% Function handle
figureHandle = figure( ...
    'Name', description, ...
    'NumberTitle', 'off', ...
    'Color', Default.BackgroundColor ...
    );

% Serie
serie = subplot(2,1,1);
te.plotSerie(startRange, endRange, fun, serie);

% ProfitLoss
profitLoss = subplot(2,1,2);
te.plotProfitLoss(startRange, endRange, profitLoss);

% Link axes views over x
linkaxes([serie, profitLoss],'x');

% Corrections
plotCorrection(figureHandle);

% Output
if nargout == 1
    fig = figureHandle;
end

end
