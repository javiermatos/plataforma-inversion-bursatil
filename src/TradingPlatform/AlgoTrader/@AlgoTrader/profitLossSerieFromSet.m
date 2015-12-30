
function profitLossSerie = profitLossSerieFromSet(algoTrader, set)

if set == 0
    profitLossSerie = algoTrader.profitLossSerie(algoTrader.InitialIndex, algoTrader.SplitIndex, false);
elseif set == 1
    profitLossSerie = algoTrader.profitLossSerie(algoTrader.SplitIndex, [], false);
else
    error('Wrong set.');
end

end
