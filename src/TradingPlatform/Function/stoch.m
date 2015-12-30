
function stochastic = stoch(highSerie, lowSerie, closeSerie, stochasticSamples)

N = length(closeSerie);

% Highest high
hhigh = NaN(1,N);
for i = stochasticSamples:N
    hhigh(i) = max(highSerie(i-stochasticSamples+1:i));
end

% Lowest low
llow = NaN(1,N);
for i = stochasticSamples:N
    llow(i) = min(lowSerie(i-stochasticSamples+1:i));
end

nonZeros = hhigh-llow ~= 0;

stochastic = NaN(1,N);
stochastic(nonZeros) = 100*(closeSerie(nonZeros)-llow(nonZeros))./(hhigh(nonZeros)-llow(nonZeros));
%stochastic(nonZeros) = (closeSerie(nonZeros)-llow(nonZeros))./(hhigh(nonZeros)-llow(nonZeros));

end
