
function [ startIndex, endIndex ] = fragmentTrainingRange(te, fragmentNumber)

if fragmentNumber < 1 || fragmentNumber > te.Fragments
    error(['fragmentNumber not valid. It must be in [1,', num2str(te.Fragments), ']']);
end

startIndex = te.BeginningIndex+te.Jump*(fragmentNumber-1);

endIndex = min(startIndex+te.FragmentSize-1, te.FinancialTimeSerie.Length);

end
