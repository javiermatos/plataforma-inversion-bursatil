
function [ startIndex, endIndex ] = fragmentRange(tef, fragmentNumber)

if fragmentNumber < 1 || fragmentNumber > tef.Fragments
    error(['fragmentNumber not valid. It must be in [1,', num2str(tef.Fragments), ']']);
end

startIndex = tef.BeginningIndex+tef.Jump*(fragmentNumber-1);

endIndex = min(startIndex+tef.FragmentSize-1, tef.FinancialTimeSerie.Length);

end
