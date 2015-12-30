
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
leadMovingAverage = movavg(fts.Serie, te.Mode, te.Lead);
lagMovingAverage = movavg(fts.Serie, te.Mode, te.Lag);

signal = zeros(1, fts.Length, 'int8');
% Signal calculation
signal(leadMovingAverage>(lagMovingAverage*(1+te.RiseThreshold))) = 1;  % Buy signal
signal(leadMovingAverage<(lagMovingAverage*(1-te.FallThreshold))) = -1; % Sell signal

end
