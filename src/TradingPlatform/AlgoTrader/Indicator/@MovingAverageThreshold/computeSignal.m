
function computeSignal(algoTrader)

if (algoTrader.RiseThreshold < algoTrader.FallThreshold)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    %warning('FallThreshold must be smaller than RiseThreshold');
    
else
    
    % Parameters
    serie = algoTrader.DataSerie.Serie;
    
    % Moving Average and threshold
    [movingAverage, riseThreshold, fallThreshold] = algoTrader.bareOutput();
    
    % Signal
    signal = zeros(1, length(serie));
    signal(serie>riseThreshold) = 1;
    signal(serie<fallThreshold) = -1;
    
    % Set Signal property
    algoTrader.Signal = signal;
    
end

end
