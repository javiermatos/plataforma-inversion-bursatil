
function computeSignal(algoTrader)

% Parameters
riseThreshold = algoTrader.RiseThreshold;
fallThreshold = algoTrader.FallThreshold;

% Stochastic
[stochastic, k, d] = algoTrader.bareOutput();

%
N = length(k);

%
% Cross up fallThreshold (event of type 0)
a = k<=fallThreshold;
b = k>fallThreshold;
indexEvent0 = find(([0 a(1:end-1)] + b) == 2);

% Cross up riseThreshold (event of type 1)
a = k<=riseThreshold;
b = k>riseThreshold;
indexEvent1 = find(([0 a(1:end-1)] + b) == 2);

%
% Cross down riseThreshold (event of type 2)
a = k>=riseThreshold;
b = k<riseThreshold;
indexEvent2 = find(([0 a(1:end-1)] + b) == 2);

% Cross down fallThreshold (event of type 3)
a = k>=fallThreshold;
b = k<fallThreshold;
indexEvent3 = find(([0 a(1:end-1)] + b) == 2);

% Sequence of events
sequenceOfEvents = sortrows( ...
    [ ...
    0*ones(1, length(indexEvent0))' indexEvent0' ; ...
    1*ones(1, length(indexEvent1))' indexEvent1' ; ...
    2*ones(1, length(indexEvent2))' indexEvent2' ; ...
    3*ones(1, length(indexEvent3))' indexEvent3' ...
    ], 2);


% Initialize signal
signal = zeros(1, N);

% State machine
currentPosition = 0;
previousIndex = 1;
for i = 1:size(sequenceOfEvents,1)
    
    eventType = sequenceOfEvents(i,1);
    currentIndex = sequenceOfEvents(i,2);
    
    switch eventType
        
        case 0
            currentPosition = 1;
            previousIndex = currentIndex;
            
        case 1
            signal(previousIndex:currentIndex) = currentPosition;
            currentPosition = 0;
            
        case 2
            currentPosition = -1;
            previousIndex = currentIndex;
            
        case 3
            signal(previousIndex:currentIndex) = currentPosition;
            currentPosition = 0;
        
    end
    
end

% Set Signal property
algoTrader.Signal = signal;

end
