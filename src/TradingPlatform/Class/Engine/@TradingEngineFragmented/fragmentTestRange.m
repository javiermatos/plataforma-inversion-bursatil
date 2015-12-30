
function [ startIndex, endIndex ] = fragmentTestRange(te, fragmentNumber)

if fragmentNumber < 1 || fragmentNumber > te.Fragments
    error(['fragmentNumber not valid. It must be in [1,', num2str(te.Fragments), ']']);
end

% The start index begin one position to the right of the last index of
% the previous fragment
[ ~, startIndex ] = te.fragmentTrainingRange(fragmentNumber-1);
if startIndex ~= te.FinancialTimeSerie.Length
    startIndex = startIndex + 1;
end

% The end index is the last index of the current fragment
[ ~, endIndex ] = te.fragmentTrainingRange(fragmentNumber);

end
