
classdef MovingAveragesCrossingThreshold < MovingAveragesCrossing
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        RiseThreshold
        
        FallThreshold
        
    end
    
    
    %% Threshold
    properties (Dependent = true)
        
        Threshold  % To use with optimization functions
        
    end
    
    methods
        
        % Threshold SET
        function set.Threshold(algoTrader, Threshold)
            algoTrader.RiseThreshold = Threshold;
            algoTrader.FallThreshold = Threshold;
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAveragesCrossingThreshold(dataSerie, mode, lead, lag, riseThreshold, fallThreshold)
            
            if ~exist('mode','var'); mode = Default.MovingAveragesCrossingThreshold.Mode; end
            if ~exist('lead','var'); lead = Default.MovingAveragesCrossingThreshold.Lead; end
            if ~exist('lag','var'); lag = Default.MovingAveragesCrossingThreshold.Lag; end
            
            algoTrader = algoTrader@MovingAveragesCrossing(dataSerie, mode, lead, lag);
            
            if ~exist('riseThreshold','var'); riseThreshold = Default.MovingAveragesCrossingThreshold.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Default.MovingAveragesCrossingThreshold.FallThreshold; end
            
            algoTrader.RiseThreshold = riseThreshold;
            algoTrader.FallThreshold = fallThreshold;
            
            % Events
            addlistener(algoTrader, 'RiseThreshold', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'FallThreshold', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [leadMovingAverage, lagMovingAverage, riseThreshold, fallThreshold] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
