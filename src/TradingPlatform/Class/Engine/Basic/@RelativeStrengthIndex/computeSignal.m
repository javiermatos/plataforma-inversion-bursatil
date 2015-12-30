
function signal = computeSignal(te)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

relativeStrengthIndex = rsindex(fts.Serie, te.Samples);

signal = zeros(1, fts.Length);
signal(relativeStrengthIndex>te.HighThreshold) = -1; % Short position
signal(relativeStrengthIndex<te.LowThreshold) = 1; % Long position

end
