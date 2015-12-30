
function [longPosition, shortPosition, noPosition, initIndex, endIndex] ...
    = signal2positions(algoTrader, rangeInit, rangeEnd, applySplit)

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

% applySplit
if ~exist('applySplit','var') || isempty(applySplit)
    applySplit = true;
end

% InitialIndex and SplitIndex check
if algoTrader.InitialIndex > algoTrader.SplitIndex
    error('InitialIndex > SplitIndex');
end


%%
% applySplit
if applySplit
    if algoTrader.SplitIndex >= endIndex
        signal = zeros(1, endIndex-initIndex+1);
    elseif algoTrader.SplitIndex >= initIndex
        signal = [zeros(1, algoTrader.SplitIndex-initIndex+1) algoTrader.Signal(algoTrader.SplitIndex+1:endIndex)];
    else
        signal = algoTrader.Signal(initIndex:endIndex);
    end
else
    
    % Without applying InitialIndex
    %signal = algoTrader.Signal(initIndex:endIndex);
    
    % Applying InitialIndex
    if algoTrader.InitialIndex > endIndex
        signal = zeros(1, endIndex-initIndex+1);
    elseif algoTrader.InitialIndex > initIndex
        signal = [zeros(1, algoTrader.InitialIndex-initIndex) algoTrader.Signal(algoTrader.InitialIndex:endIndex)];
    else
        signal = algoTrader.Signal(initIndex:endIndex);
    end
    
end

% Error when length(signal) < 2
if length(signal) < 2
    error('signal input vector must have at least length 2.');
end

% AllowShortPosition
if ~algoTrader.AllowShortPosition
    % transform short position into no position. This is because maybe we
    % don't want our algotrader to stay in a short position.
    signal(signal==-1) = 0;
end

% Indexes of the signal where a transaction takes place
signalIndex = find(diff(signal))+1;
signalIndex = [1 signalIndex length(signal)];

position = [signalIndex(1:end-1)' signalIndex(2:end)'];

longPosition = position(signal(position(:,1)') == 1,:);
shortPosition = position(signal(position(:,1)') == -1,:);
noPosition = position(signal(position(:,1)') == 0,:);

end
