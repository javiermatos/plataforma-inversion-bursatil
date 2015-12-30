
function [movingAverage, upperBand, lowerBand] = bbands(serie, mode, samples, k)

% Moving Average
movingAverage = movavg(serie, mode, samples);

% Standard Deviation
if strcmpi(mode,'w') || strcmpi(mode,'weighted')
    samples = length(samples);
end

N = length(serie);
standardDeviation = NaN(1, N);
for i = samples:N
    standardDeviation(i) = std(serie(i-samples+1:i));
end

% Bands
upperBand = movingAverage+k*standardDeviation;
lowerBand = movingAverage-k*standardDeviation;

end
