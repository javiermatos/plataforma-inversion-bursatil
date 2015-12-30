
% Get index open and close positions in the signal
function [longPosition, shortPosition] = positions(signal)

% Error when length(signal) < 2
if length(signal) < 2
    error('signal input vector must have at least length 2.');
end

% Indexes of the signal where a transaction takes place
signalIdx = find(diff(signal));
% Two additional transactions if required (the initial to open a position
% and the last one to close it).
% Initial transaction
if signal(1) ~= 0, signalIdx = [ 1 signalIdx ]; end
% Last transaction
if signal(end) ~= 0, signalIdx = [ signalIdx length(signal) ]; end

% Initialize variables
%longPosition = [];
%lp = nnz(diff(find(signal==1))-1)+1
longPosition = zeros(nnz(diff(find(signal==1))-1)+1,2);
%shortPosition = [];
%sp = nnz(diff(find(signal==-1))-1)+1
shortPosition = zeros(nnz(diff(find(signal==-1))-1)+1,2);

lIndex = 1;
sIndex = 1;
for i = signalIdx
    
    % Initial transaction (or near the begining)
    if i == 1
        
        % Open long position
        if signal(i) == 1
            %longPosition = [ longPosition ; [ i NaN ] ];
            longPosition(lIndex,:) = [ i NaN ];
            
        % Open short position
        elseif signal(i) == -1
            %shortPosition = [ shortPosition ; [ i NaN ] ];
            shortPosition(sIndex,:) = [ i NaN ];
            
        % This is needed because these signal vectors:
        % signal = [ 0 1 ... ]
        % signal = [ 0 -1 ... ]
        % signal = [ 1 1 ... ]
        % return singalIdx = [ 1 ... ] but the way in which they must be
        % processed is different.
        elseif signal(i) == 0
            % Open long position
            if signal(i+1) == 1
                %longPosition = [ longPosition ; [ i+1 NaN ] ];
                longPosition(lIndex,:) = [ i+1 NaN ];
                
            % Open short position
            elseif signal(i+1) == -1
                %shortPosition = [ shortPosition ; [ i+1 NaN ] ];
                shortPosition(sIndex,:) = [ i+1 NaN ];
                
            end
        end
        
    % Last transaction
    elseif i == length(signal)
        
        % Close long position
        if signal(i) == 1
            %longPosition(end,2) = i;
            longPosition(lIndex,2) = i;
            lIndex = lIndex + 1;
            
        % Close short position
        elseif signal(i) == -1
            %shortPosition(end,2) = i;
            shortPosition(sIndex,2) = i;
            sIndex = sIndex + 1;
            
        end
    
    % Rest of transactions
    else
        
        % Close long position
        if signal(i) == 1
            %longPosition(end,2) = i+1;
            longPosition(lIndex,2) = i+1;
            lIndex = lIndex + 1;
            
        % Close short position
        elseif signal(i) == -1
            %shortPosition(end,2) = i+1;
            shortPosition(sIndex,2) = i+1;
            sIndex = sIndex + 1;
            
        end
        
        % Open long position
        if signal(i+1) == 1
            %longPosition = [ longPosition ; [ i+1 NaN ] ];
            longPosition(lIndex,:) = [ i+1 NaN ];
            
        % Open short position
        elseif signal(i+1) == -1
            %shortPosition = [ shortPosition ; [ i+1 NaN ] ];
            shortPosition(sIndex,:) = [ i+1 NaN ];
            
        end
    end
end

% Corrects last position in case that it is opened and closed at the same
% time. This is because of the policy of closing every position at the end
% of the evaluation.
if ~isempty(longPosition) && longPosition(end,1) == longPosition(end,2)
    longPosition(end,:) = [];
end
if ~isempty(shortPosition) && shortPosition(end,1) == shortPosition(end,2)
    shortPosition(end,:) = [];
end

end
