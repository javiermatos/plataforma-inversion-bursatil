
function signalFragment = computeSignalFragment(te, fragmentNumber, startIndex, endIndex)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

% Apply to that set the samples of the previous fragment (because we don't
% know yet the optimun quantity of samples of the current fragment)
samples = te.Samples(fragmentNumber-1);

% Moving Average
movingAverage = movavg(fts.Serie(startIndex-samples+1:endIndex), te.Mode, samples);
movingAverage = movingAverage(samples:end);

serieFragment = fts.Serie(startIndex:endIndex);

signalFragment = zeros(1, endIndex-startIndex+1, 'int8');
% Signal calculation
signalFragment(serieFragment>movingAverage) = 1;    % Buy signal
signalFragment(serieFragment<movingAverage) = -1;   % Sell signal

end
