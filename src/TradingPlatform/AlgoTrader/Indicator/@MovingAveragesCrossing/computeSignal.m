
function computeSignal(algoTrader)

if (algoTrader.Lag < algoTrader.Lead)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    %warning('Lead must be smaller than lag');
    
else
    
    % Moving Average
    [leadMovingAverage, lagMovingAverage] = algoTrader.bareOutput();

    % Signal
    signal = zeros(1, length(leadMovingAverage));
    signal(leadMovingAverage>lagMovingAverage) = 1;
    signal(leadMovingAverage<lagMovingAverage) = -1;

    % Set Signal property
    algoTrader.Signal = signal;
    
end

end
