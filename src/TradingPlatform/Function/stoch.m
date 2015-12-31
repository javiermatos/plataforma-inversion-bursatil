
function stochastic = stoch(highSerie, lowSerie, closeSerie, samples)

N = length(closeSerie);

% Highest high
hhigh = NaN(1,N);
for i = samples:N
    hhigh(i) = max(highSerie(i-samples+1:i));
end

% Lowest low
llow = NaN(1,N);
for i = samples:N
    llow(i) = min(lowSerie(i-samples+1:i));
end

nonZeros = hhigh-llow ~= 0;

stochastic = NaN(1,N);
stochastic(nonZeros) = 100*(closeSerie(nonZeros)-llow(nonZeros))./(hhigh(nonZeros)-llow(nonZeros));
%stochastic(nonZeros) = (closeSerie(nonZeros)-llow(nonZeros))./(hhigh(nonZeros)-llow(nonZeros));

end
