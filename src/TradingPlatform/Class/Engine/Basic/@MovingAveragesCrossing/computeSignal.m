
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

if ~(te.Lag > te.Lead)
    error('Lead must be smaller than lagging.');
end

% Moving Average
leadMovingAverage = movavg(fts.Serie, te.Mode, te.Lead);
lagMovingAverage = movavg(fts.Serie, te.Mode, te.Lag);

% Signal calculation
signal = zeros(1, fts.Length, 'int8');
signal(leadMovingAverage>lagMovingAverage) = 1;     % Buy signal
signal(leadMovingAverage<lagMovingAverage) = -1;    % Sell signal

end
