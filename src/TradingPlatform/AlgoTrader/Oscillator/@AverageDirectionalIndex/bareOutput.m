
function [plusDirectionalMovement, minusDirectionalMovement, directionalMovementIndex, averageDirectionalIndex] ...
            = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
mode = algoTrader.Mode;
samples = algoTrader.Samples;
serie = algoTrader.DataSerie.Serie(max(initIndex-samples+1,1):endIndex);

%
N = length(serie);

diffSerie = diff(serie);
plusDirectionalMovement = diffSerie.*(diffSerie>0);
minusDirectionalMovement = -1*(diffSerie.*(diffSerie<0)); 

sumMovement = zeros(1,N);
diffMovement = zeros(1,N);
for i = 1:samples
    sumMovement = sumMovement + [zeros(1,i) plusDirectionalMovement(1:end-i+1)];
    diffMovement = diffMovement + [zeros(1,i) minusDirectionalMovement(1:end-i+1)];
end

directionalMovementIndex = abs(sumMovement-diffMovement)./(sumMovement+diffMovement);

% averageDirectionalIndex
averageDirectionalIndex = movavg(directionalMovementIndex, mode, samples);

% Cut to fit the size
plusDirectionalMovement = [0 plusDirectionalMovement];
plusDirectionalMovement = plusDirectionalMovement(end-(endIndex-initIndex):end);

minusDirectionalMovement = [0 minusDirectionalMovement];
minusDirectionalMovement = minusDirectionalMovement(end-(endIndex-initIndex):end);

directionalMovementIndex = directionalMovementIndex(end-(endIndex-initIndex):end);

averageDirectionalIndex = averageDirectionalIndex(end-(endIndex-initIndex):end);

end
