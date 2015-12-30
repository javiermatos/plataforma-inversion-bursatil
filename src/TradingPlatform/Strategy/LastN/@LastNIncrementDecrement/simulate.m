
function simulate(algoTrader)

% Parameters
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie;

N = length(serie);

risingTrend = serie(1:end-1)<serie(2:end);
nRisingTrend = zeros(1, N);

fallingTrend = serie(1:end-1)>serie(2:end);
nFallingTrend = zeros(1, N);

for i = 1:samples
    nRisingTrend = nRisingTrend + [zeros(1,i) risingTrend(1:end-i+1)];
    nFallingTrend = nFallingTrend + [zeros(1,i) fallingTrend(1:end-i+1)];
end

signal = zeros(1, N);
signal(nRisingTrend>nFallingTrend) = 1;
signal(nRisingTrend<nFallingTrend) = -1;
signal(1:samples) = 0;

algoTrader.Signal = signal;

end
