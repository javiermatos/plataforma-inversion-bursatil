
function recursiveInitialIndexRatio(algoTrader, src, event)

for i = 1:length(algoTrader.Set)
    
    algoTrader.Set{i}.InitialIndexRatio = algoTrader.InitialIndexRatio;
    
end

end
