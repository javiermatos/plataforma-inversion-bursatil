
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

[~, upperBand, lowerBand] = bbands(fts.Serie, te.Mode, te.Samples, te.K);

% Signal calculation
signal = zeros(1, fts.Length, 'int8');
signal(fts.Serie>upperBand) = -1;   % Buy signal
signal(fts.Serie<lowerBand) = 1;    % Sell signal

end
