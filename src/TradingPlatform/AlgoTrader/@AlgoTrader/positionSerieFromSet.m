
function positionSerie = positionSerieFromSet(algoTrader, set)

if set == 0
    positionSerie = algoTrader.positionSerie(algoTrader.InitialIndex, algoTrader.SplitIndex, false);
elseif set == 1
    positionSerie = algoTrader.positionSerie(algoTrader.SplitIndex, [], false);
else
    error('Wrong set.');
end

end
