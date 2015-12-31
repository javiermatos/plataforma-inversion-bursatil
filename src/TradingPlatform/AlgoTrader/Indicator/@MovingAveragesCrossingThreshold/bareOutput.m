
function [leadMovingAverage, lagMovingAverage, riseThreshold, fallThreshold] = bareOutput(algoTrader, initIndex, endIndex)

% initIndex
if ~exist('initIndex','var'); initIndex = 1; end
% endIndex
if ~exist('endIndex','var'); endIndex = algoTrader.DataSerie.Length; end

% Parameters
propertyRiseThreshold = algoTrader.RiseThreshold;
propertyFallThreshold = algoTrader.FallThreshold;

% Moving Average
[leadMovingAverage, lagMovingAverage] = bareOutput@MovingAveragesCrossing(algoTrader, initIndex, endIndex);

% Threshold bands
riseThreshold = lagMovingAverage*propertyRiseThreshold;
fallThreshold = lagMovingAverage*propertyFallThreshold;

end
