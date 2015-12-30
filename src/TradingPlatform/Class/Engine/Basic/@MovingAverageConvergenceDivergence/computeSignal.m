
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
leadMovingAverage = movavg(fts.Serie, te.Mode, te.Lead);
lagMovingAverage = movavg(fts.Serie, te.Mode, te.Lag);
macd = leadMovingAverage-lagMovingAverage;
compound = movavg(macd, te.Mode, te.Samples);
%histogram = macd-compound;

% Signal
signal = zeros(1, fts.Length, 'int8');
signal(macd>compound) = 1;    % Buy signal
signal(macd<compound) = -1;   % Sell signal

end
