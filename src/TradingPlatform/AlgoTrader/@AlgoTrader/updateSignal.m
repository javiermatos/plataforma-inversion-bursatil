
function updateSignal(algoTrader, src, event)

if isempty(algoTrader.Signal);
    algoTrader.computeSignal();
end

end
