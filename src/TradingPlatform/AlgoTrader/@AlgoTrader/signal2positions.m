
function [longPosition, shortPosition, noPosition, initIndex, endIndex] ...
    = signal2positions(algoTrader, setSelector, rangeInit, rangeEnd)

%% Process arguments

% rangeInit
if ~exist('rangeInit','var') || isempty(rangeInit)
    initIndex = 1;
elseif isscalar(rangeInit)
    initIndex = rangeInit;
elseif ischar(rangeInit)
    initIndex = algoTrader.DataSerie.firstFrom(rangeInit);
end

% rangeEnd
if ~exist('rangeEnd','var') || isempty(rangeEnd)
    endIndex = algoTrader.DataSerie.Length;
elseif isscalar(rangeEnd)
    endIndex = rangeEnd;
elseif ischar(rangeEnd)
    endIndex = algoTrader.DataSerie.lastUntil(rangeEnd);
end

% Incorrect range
if initIndex > endIndex
    error('rangeInit > rangeEnd');
end

% setSelector
if ~exist('setSelector','var') || isempty(setSelector)
    setSelector = Default.TargetSet;
end

% setSelector
switch setSelector
    
    case 0 % Training set
        
        lowerIndex = algoTrader.TrainingSet(1);
        upperIndex = algoTrader.TrainingSet(2);

        if lowerIndex > endIndex || upperIndex < initIndex
            signal = zeros(1, endIndex-initIndex+1);
        else
            signal = [zeros(1, lowerIndex-initIndex) algoTrader.Signal(max(lowerIndex,initIndex):min(upperIndex,endIndex)) zeros(1, endIndex-upperIndex)];
        end
        
    case 1 % Test set
        
        lowerIndex = algoTrader.TestSet(1);
        upperIndex = algoTrader.TestSet(2);

        if lowerIndex > endIndex || upperIndex < initIndex
            signal = zeros(1, endIndex-initIndex+1);
        else
            signal = [zeros(1, lowerIndex-initIndex) algoTrader.Signal(max(lowerIndex,initIndex):min(upperIndex,endIndex)) zeros(1, endIndex-upperIndex)];
        end
        
    case 2 % Both sets
    
        lowerIndex = min(algoTrader.TrainingSet(1), algoTrader.TestSet(1));
        upperIndex = max(algoTrader.TrainingSet(2), algoTrader.TestSet(2));

        if lowerIndex > endIndex || upperIndex < initIndex
            % Outside
            signal = zeros(1, endIndex-initIndex+1);
        elseif algoTrader.TrainingSet(1) <= algoTrader.TestSet(1) && algoTrader.TrainingSet(2) >= algoTrader.TestSet(1) || ...
                algoTrader.TestSet(1) <= algoTrader.TrainingSet(1) && algoTrader.TestSet(2) >= algoTrader.TrainingSet(1)
            % Overlap
            signal = [zeros(1, lowerIndex-initIndex) algoTrader.Signal(max(lowerIndex,initIndex):min(upperIndex,endIndex)) zeros(1, endIndex-upperIndex)];
        else
            % Disjoint
            b = max(algoTrader.TrainingSet(1), algoTrader.TestSet(1));
            a = min(algoTrader.TrainingSet(2), algoTrader.TestSet(2));
            signal = [zeros(1, lowerIndex-initIndex) algoTrader.Signal(max(lowerIndex,initIndex):a) zeros(1, b-a-1) algoTrader.Signal(b:min(upperIndex,endIndex)) zeros(1, endIndex-upperIndex)];
        end
        
    case 3 % All
        
        signal = algoTrader.Signal(initIndex:endIndex);
        
    otherwise
        
        error('Wrong set selector: 0 = TrainingSet, 1 = TestSet, 2 = Both, 3 = All.');
        
end

% Error when length(signal) < 2
if length(signal) < 2
    error('Input vector must have at least length 2.');
end

% Indexes of the signal where a transaction takes place
signalIndex = [1 find(diff(signal))+1 length(signal)];

position = [signalIndex(1:end-1)' signalIndex(2:end)'];

longPosition = position(signal(position(:,1)') == 1,:);
shortPosition = position(signal(position(:,1)') == -1,:);
noPosition = position(signal(position(:,1)') == 0,:);
% NaN is a noPosition
noPosition = [noPosition; position(isnan(signal(position(:,1)')),:)];

end
