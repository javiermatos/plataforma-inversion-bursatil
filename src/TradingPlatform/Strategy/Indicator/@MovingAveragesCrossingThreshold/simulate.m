
function simulate(algoTrader)

if ~(algoTrader.Lag > algoTrader.Lead)
    
    algoTrader.Signal = zeros(1, length(algoTrader.DataSerie.Serie));
    
else

    % Parameters
    mode = algoTrader.Mode;
    lead = algoTrader.Lead;
    lag = algoTrader.Lag;
    riseThreshold = algoTrader.RiseThreshold;
    fallThreshold = algoTrader.FallThreshold;
    serie = algoTrader.DataSerie.Serie;

    % Moving Average
    leadMovingAverage = movavg(serie, mode, lead);
    lagMovingAverage = movavg(serie, mode, lag);

    % Signal
    signal = zeros(1, length(serie));
    signal(leadMovingAverage>(lagMovingAverage*(1+riseThreshold))) = 1;
    signal(leadMovingAverage<(lagMovingAverage*(1-fallThreshold))) = -1;

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
% % Parameters
% mode = algoTrader.Mode;
% lead = algoTrader.Lead;
% lag = algoTrader.Lag;
% riseThreshold = algoTrader.RiseThreshold;
% fallThreshold = algoTrader.FallThreshold;
% serie = algoTrader.DataSerie.Serie;
% 
% % Moving Average
% leadMovingAverage = movavg(serie, mode, lead);
% lagMovingAverage = movavg(serie, mode, lag);
% 
% % Signal
% signal = zeros(1, length(serie));
% signal(leadMovingAverage>(lagMovingAverage*(1+riseThreshold))) = 1;
% signal(leadMovingAverage<(lagMovingAverage*(1-fallThreshold))) = -1;
% 
% % Set Signal property
% algoTrader.Signal = signal;
% 
% end
