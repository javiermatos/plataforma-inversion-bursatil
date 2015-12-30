
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% Moving Average
movingAverage = movavg(fts.Serie, te.Mode, te.Samples);

% Displace moving average
d = te.Displacement;
movingAverage = [ NaN(d,1) ; movingAverage(1:end-d) ];

signal = zeros(1, fts.Length, 'int8');
% Signal calculation
signal(fts.Serie>movingAverage) = 1;    % Buy signal
signal(fts.Serie<movingAverage) = -1;   % Sell signal

end
