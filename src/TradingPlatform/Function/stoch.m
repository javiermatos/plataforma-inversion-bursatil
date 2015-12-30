
function [stochastic, movingAverage] = stoch(highSerie, lowSerie, closeSerie, stochasticSamples, mode, movingAverageSamples)

N = length(closeSerie);

% Highest high
hhigh = NaN(N,1);
for i = stochasticSamples:N
    hhigh(i) = max(highSerie(i-stochasticSamples+1:i));
end

% Lowest low
llow = NaN(N,1);
for i = stochasticSamples:N
    llow(i) = min(lowSerie(i-stochasticSamples+1:i));
end

nonZeros = hhigh-llow ~= 0;

stochastic = NaN(N,1);
stochastic(nonZeros) = (closeSerie(nonZeros)-llow(nonZeros))./(hhigh(nonZeros)-llow(nonZeros));

% movingAverage if requested
if nargout == 2
    movingAverage = NaN(N,1);
    movingAverage(~isnan(stochastic)) = movavg(stochastic(~isnan(stochastic)), mode, movingAverageSamples);
end

end
