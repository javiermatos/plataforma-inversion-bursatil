% Get range of different positions as signal index
function [longPosition, shortPosition, noPosition] = signal2positions(te, type, startRange, endRange)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% startIndex
if ~exist('startRange','var'); startRange = 1; end
% endIndex
if ~exist('endRange','var'); endRange = fts.Length; end

[startIndex, endIndex] = fts.range2index(startRange, endRange);

%type
switch lower(type)
    
    case 'date'
        % Full date
        signalDate = fts.Date(startIndex:endIndex);
        fun = @(index) signalDate(index);
        
    case 'index'
        % Relative index
        fun = @(index) index;
        
    otherwise
        disp(type);
        error('type must be ''date'' or ''index''.');
        
end

if startIndex > endIndex
    longPosition = [];
    shortPosition = [];
    noPosition = [];
    return;
end

% Takes the signal in range
signal = te.Signal(startIndex:endIndex);

% Indexes of the signal where a transaction takes place
signalIndex = find(diff(signal));

% Error when length(signal) < 2
if length(signal) < 2
    error('signal input vector must have at least length 2.');
end

% Initialize variables
% Long positions
longPosition = zeros(regionsWithValue(signal,1),2);
% Short positions
shortPosition = zeros(regionsWithValue(signal,-1),2);
% No positions
noPosition = zeros(regionsWithValue(signal,0),2);

lpIndex = 1;
spIndex = 1;
npIndex = 1;

% First transaction
if signal(1) == 1
    longPosition(lpIndex,:) = [ fun(1) NaN ];
elseif signal(1) == -1
    shortPosition(spIndex,:) = [ fun(1) NaN ];
elseif signal(1) == 0
    noPosition(npIndex,:) = [ fun(1) NaN ];
end

% Rest of transactions
for i = signalIndex
    
    % Close long position
    if signal(i) == 1
        longPosition(lpIndex,2) = fun(i+1);
        lpIndex = lpIndex + 1;
        
        % Close short position
    elseif signal(i) == -1
        shortPosition(spIndex,2) = fun(i+1);
        spIndex = spIndex + 1;
        
        % Close no position
    elseif signal(i) == 0
        noPosition(npIndex,2) = fun(i+1);
        npIndex = npIndex + 1;
    end
    
    % Open long position
    if signal(i+1) == 1
        longPosition(lpIndex,:) = [ fun(i+1) NaN ];
        
        % Open short position
    elseif signal(i+1) == -1
        shortPosition(spIndex,:) = [ fun(i+1) NaN ];
        
        % Open no position
    elseif signal(i+1) == 0
        noPosition(npIndex,:) = [ fun(i+1) NaN ];
        
    end
    
end

% Last transaction
if signal(end) == 1
    longPosition(lpIndex,2) = fun(length(signal));
elseif signal(end) == -1
    shortPosition(spIndex,2) = fun(length(signal));
elseif signal(end) == 0
    noPosition(npIndex,2) = fun(length(signal));
end

end

function n = regionsWithValue(signal, value)

index = find(signal==value);
if ~isempty(index)
    n = nnz(diff(index)-1)+1;
else
    n = 0;
end

end
