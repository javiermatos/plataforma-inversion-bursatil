
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% First tail fragment
firstTailFragment = ceil((fts.Length-te.BeginningIndex-te.FragmentSize+1)/te.Jump)+1;

signal = zeros(1, fts.Length, 'int8');
% First fragment is for learning purspose
for i = 2:firstTailFragment
    
    % The start index begin one position to the right of the last index of
    % the previous fragment
    [ ~, startIndex ] = te.fragmentTrainingRange(i-1);
    startIndex = startIndex + 1;
    % The end index is the last index of the current fragment
    [ ~, endIndex ] = te.fragmentTrainingRange(i);
    
    signal(startIndex:endIndex) = te.computeSignalFragment(startIndex,endIndex,i);
    
end

end
