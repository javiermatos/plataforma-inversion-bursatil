
function updateSignal(algoTrader, src, event)

if isempty(algoTrader.Signal);
    algoTrader.simulate();
end

end
