
function simulate(algoTrader)

% Parameters
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie;

N = length(serie);

trend = diff(serie);
nTrend = zeros(1, N);

for i = 1:samples
    nTrend = nTrend + [zeros(1,i) trend(1:end-i+1)];
end

signal = zeros(1, N);
signal(nTrend>0) = 1;
signal(nTrend<0) = -1;
signal(1:samples) = 0;

algoTrader.Signal = signal;

end
