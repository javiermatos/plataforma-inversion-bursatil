
function signal = computeSignal(te)

% Financial Time Serie
fts = te.FinancialTimeSerie;

% First tail fragment
firstTailFragmentIndex = te.firstTailFragment();

signal = zeros(1, fts.Length, 'int8');
% First fragment is for learning purspose
for i = 2:firstTailFragmentIndex
    
    [startIndex, endIndex] = te.fragmentTestRange(i);
    
    signal(startIndex:endIndex) = te.computeSignalFragment(startIndex,endIndex);
    
end

end
