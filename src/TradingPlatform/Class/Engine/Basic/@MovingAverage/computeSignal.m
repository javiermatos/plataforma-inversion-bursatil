
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
movingAverage = movavg(fts.Serie, te.Mode, te.Samples);

% Signal
signal = zeros(1, fts.Length, 'int8');
signal(fts.Serie>movingAverage) = 1;    % Buy signal
signal(fts.Serie<movingAverage) = -1;   % Sell signal

end
