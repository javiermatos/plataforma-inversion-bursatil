
function updateFragment(algoTrader, src, event)

if isempty(algoTrader.Fragment);
    
    % All fragments including non-completed fragments
    %fragments = ceil((algoTrader.DataSerie.Length-algoTrader.InitialIndex+1)/algoTrader.Jump);
    
    % Only completed fragments
    fragments = ceil((algoTrader.DataSerie.Length-algoTrader.InitialIndex-algoTrader.Size+1)/algoTrader.Jump)+1;
    
    algoTrader.Fragment = algoTrader.AlgoTraderBase.empty(0, fragments);
    
    for i = 1:fragments
        
        algoTrader.Fragment(i) = algoTrader.AlgoTraderBase.clone();
        
        initialIndex = algoTrader.InitialIndex+(i-1)*algoTrader.Jump;
        splitIndex = min(initialIndex+algoTrader.Size-1, algoTrader.DataSerie.Length);
        
        algoTrader.Fragment(i).InitialIndex = initialIndex;
        algoTrader.Fragment(i).SplitIndex = splitIndex;
        
    end
    
end

end
