
function [movingAverage, upperBand, lowerBand] = bbands(serie, samples, k)

% Moving Average
movingAverage = movavg(serie, 's', samples);

N = length(serie);
standardDeviation = NaN(1, N);
for i = samples:N
    standardDeviation(i) = sqrt((sum(serie(i-samples+1:i).^2)/samples)-(movingAverage(i)^2));
end

% Bands
upperBand = movingAverage+k*standardDeviation;
lowerBand = movingAverage-k*standardDeviation;

end
