
function computeSignal(algoTrader)

if ((algoTrader.Slow < algoTrader.Middle) || (algoTrader.Middle < algoTrader.Fast))
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    %warning('Fast must be smaller than Middle and Middle smaller than Slow');
    
else
    
    % Moving Average
    [fastMovingAverage, middleMovingAverage, slowMovingAverage] = algoTrader.bareOutput();

    % Signal
    signal = zeros(1, length(fastMovingAverage));
    signal((fastMovingAverage > middleMovingAverage) & (middleMovingAverage > slowMovingAverage)) = 1;
    signal((fastMovingAverage < middleMovingAverage) & (middleMovingAverage < slowMovingAverage)) = -1;

    % Set Signal property
    algoTrader.Signal = signal;
    
end

end
