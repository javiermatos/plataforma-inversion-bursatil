
function computeSignal(algoTrader)

if (algoTrader.Lag < algoTrader.Lead)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    %warning('Lead must be smaller than lag');
    
elseif (algoTrader.RiseThreshold < algoTrader.FallThreshold)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    %warning('FallThreshold must be smaller than RiseThreshold');
    
else
    
    % Parameters
    serie = algoTrader.DataSerie.Serie;
    
    % Moving Average
    [leadMovingAverage, lagMovingAverage, riseThreshold, fallThreshold] = algoTrader.bareOutput();
    
    % Signal
    signal = zeros(1, length(serie));
    signal(leadMovingAverage>riseThreshold) = 1;
    signal(leadMovingAverage<fallThreshold) = -1;
    
    % Set Signal property
    algoTrader.Signal = signal;
    
end

end
