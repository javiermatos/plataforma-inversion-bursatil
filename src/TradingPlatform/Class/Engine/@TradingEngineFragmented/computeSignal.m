
function signal = computeSignal(tef)

% Financial Time Serie
fts = tef.FinancialTimeSerie;

% First tail fragment
firstTailFragment = ceil((fts.Length-tef.BeginningIndex-tef.FragmentSize+1)/tef.Jump)+1;

signal = zeros(1, fts.Length, 'int8');
% First fragment is for learning purspose
for i = 2:firstTailFragment
    
    % The start index begin one position to the right of the last index of
    % the previous fragment
    [ ~, startIndex ] = tef.fragmentRange(i-1);
    startIndex = startIndex + 1;
    % The end index is the last index of the current fragment
    [ ~, endIndex ] = tef.fragmentRange(i);
    
    signal(startIndex:endIndex) = tef.computeSignalFragment(i,startIndex,endIndex);
    
end

end
