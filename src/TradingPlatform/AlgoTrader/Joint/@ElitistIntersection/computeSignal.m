
function computeSignal(algoTrader)

if any(algoTrader.Selection)
    
    innerSignal = cellfun(@(algoTrader) algoTrader.Signal, algoTrader.InnerAlgoTrader(logical(algoTrader.Selection)), 'UniformOutput', false);

    N = length(innerSignal);
    S = length(algoTrader.DataSerie.Serie);

    longPosition = ones(1,S);
    for i = 1:N
        longPosition = longPosition & (innerSignal{i} == 1);
    end

    shortPosition = ones(1,S);
    for i = 1:N
        shortPosition = shortPosition & (innerSignal{i} == -1);
    end

    % noPosition = ones(1,S);
    % for i = 1:N
    %     noPosition = noPosition & (innerSignal{i} == 0);
    % end

    signal = zeros(1,S);
    signal(longPosition) = 1;
    signal(shortPosition) = -1;
    % signal(noPosition) = 0;
    
else
    
    signal = zeros(1,length(algoTrader.DataSerie.Serie));
    
end

algoTrader.Signal = signal;

end
