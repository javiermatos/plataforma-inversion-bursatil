
function signal = computeSignal(te)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

stochastic = stoch(fts.High, fts.Low, fts.Close, te.StochasticSamples);

signal = zeros(1, fts.Length);
signal(stochastic>te.HighThreshold) = 1; % Long position
signal(stochastic<te.LowThreshold) = -1; % Short position

end
