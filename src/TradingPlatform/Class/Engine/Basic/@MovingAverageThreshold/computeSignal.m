
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
movingAverage = movavg(fts.Serie, te.Mode, te.Samples);

signal = zeros(1, fts.Length, 'int8');
% Signal calculation
signal(fts.Serie>(movingAverage*(1+te.RiseThreshold))) = 1;     % Buy signal
signal(fts.Serie<(movingAverage*(1-te.FallThreshold))) = -1;    % Sell signal

end
