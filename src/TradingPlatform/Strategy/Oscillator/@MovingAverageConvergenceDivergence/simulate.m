
function simulate(algoTrader)

if ~(algoTrader.Lag > algoTrader.Lead)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    
else
    
    mode = algoTrader.Mode;
    lead = algoTrader.Lead;
    lag = algoTrader.Lag;
    signalMode = algoTrader.SignalMode;
    signalSamples = algoTrader.SignalSamples;
    serie = algoTrader.DataSerie.Serie;
    
    % Moving Average
    leadMovingAverage = movavg(serie, mode, lead);
    lagMovingAverage = movavg(serie, mode, lag);
    
    % MACD
    diff = leadMovingAverage-lagMovingAverage;
    
    % Signal
    diffMovingAverage = movavg(diff(lag:end), signalMode, signalSamples);
    diffMovingAverage = [ NaN(1, lag-1) diffMovingAverage ];
    
    % Histogram
    %histogram = diff-diffMovingAverage;
    
    % Signal
    signal = zeros(1, length(serie));
    signal(diff>diffMovingAverage) = 1;
    signal(diff<diffMovingAverage) = -1;
    
    % Set Signal property
    algoTrader.Signal = signal;
    
end

end

% function simulate(algoTrader)
% 
% if ~(algoTrader.Lag > algoTrader.Lead)
%     error('Lead must be smaller than lagging.');
% end
% 
% mode = algoTrader.Mode;
% lead = algoTrader.Lead;
% lag = algoTrader.Lag;
% signalMode = algoTrader.SignalMode;
% signalSamples = algoTrader.SignalSamples;
% serie = algoTrader.DataSerie.Serie;
% 
% % Moving Average
% leadMovingAverage = movavg(serie, mode, lead);
% lagMovingAverage = movavg(serie, mode, lag);
% 
% % MACD
% diff = leadMovingAverage-lagMovingAverage;
% 
% % Signal
% diffMovingAverage = movavg(diff(lag:end), signalMode, signalSamples);
% diffMovingAverage = [ NaN(1, lag-1) diffMovingAverage ];
% 
% % Histogram
% %histogram = diff-diffMovingAverage;
% 
% % Signal
% signal = zeros(1, length(serie));
% signal(diff>diffMovingAverage) = 1;
% signal(diff<diffMovingAverage) = -1;
% 
% % Set Signal property
% algoTrader.Signal = signal;
% 
% end
