
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

% Oscillator
oscillator = subplot(4,1,3);
te.plotOscillator(startRange, endRange, oscillator);

% ProfitLoss
profitLoss = subplot(4,1,4);
te.plotProfitLoss(startRange, endRange, profitLoss);

% Link axes views over x
linkaxes([serie, oscillator, profitLoss],'x');

% Corrections
plotCorrection(figureHandle);

% Output
if nargout == 1
    fig = figureHandle;
end

end
