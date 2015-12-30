
function signalFragment = computeSignalFragment(te, fragmentNumber, startIndex, endIndex)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

% Apply to that set the samples of the previous fragment (because we don't
% know yet the optimun quantity of leading/lagging of the current fragment)
lead = te.Lead(fragmentNumber-1);
lag = te.Lag(fragmentNumber-1);

% Moving Average
leadMovingAverage = movavg(fts.Serie(startIndex-lead+1:endIndex), te.Mode, lead);
leadMovingAverage = leadMovingAverage(lead:end);
lagMovingAverage = movavg(fts.Serie(startIndex-lag+1:endIndex), te.Mode, lag);
lagMovingAverage = lagMovingAverage(lag:end);

signalFragment = zeros(1, endIndex-startIndex+1, 'int8');
% Signal calculation
signalFragment(leadMovingAverage>lagMovingAverage) = 1;     % Buy signal
signalFragment(leadMovingAverage<lagMovingAverage) = -1;    % Sell signal

end