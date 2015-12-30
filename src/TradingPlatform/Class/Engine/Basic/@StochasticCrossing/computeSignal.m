
function signal = computeSignal(te)

% FinancialTimeSerie
fts = te.FinancialTimeSerie;

[stochastic, movingAverage] = stoch(fts.High, fts.Low, fts.Close, te.StochasticSamples, te.Mode, te.MovingAverageSamples);

signal = zeros(1, fts.Length);
signal((stochastic>movingAverage)&(stochastic>te.HighThreshold)) = 1;  % Long position
signal((stochastic<movingAverage)&(stochastic<te.LowThreshold)) = -1;  % Short position

end
