
function profitLoss = profitLossFromSet(algoTrader, set)

if set == 0
    profitLoss = algoTrader.profitLoss(algoTrader.InitialIndex, algoTrader.SplitIndex, false);
elseif set == 1
    profitLoss = algoTrader.profitLoss(algoTrader.SplitIndex, [], false);
else
    error('Wrong set.');
end

end
