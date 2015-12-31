
function movingAverageDisplaced = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
displacement = algoTrader.Displacement;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples-displacement+1,1):endIndex);

% Moving Average
movingAverageDisplaced = movavg(serie, mode, samples);
movingAverageDisplaced = movingAverageDisplaced(max(end-(endIndex-initIndex)-displacement,1):end-displacement);
movingAverageDisplaced = [ NaN(1,(endIndex-initIndex+1)-length(movingAverageDisplaced)) movingAverageDisplaced ];

end
