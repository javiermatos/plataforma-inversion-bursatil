
function fragmentIndex = firstTailFragment(te)

% First tail fragment
fragmentIndex = ceil((te.FinancialTimeSerie.Length-te.BeginningIndex-te.FragmentSize+1)/te.Jump)+1;

end
