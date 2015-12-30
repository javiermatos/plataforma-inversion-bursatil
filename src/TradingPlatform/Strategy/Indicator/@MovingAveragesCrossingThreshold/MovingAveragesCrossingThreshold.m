
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
            
            if ~exist('mode','var'); mode = Settings.MovingAveragesCrossing.Mode; end
            if ~exist('lead','var'); lead = Settings.MovingAveragesCrossing.Lead; end
            if ~exist('lag','var'); lag = Settings.MovingAveragesCrossing.Lag; end
            
            algoTrader = algoTrader@MovingAveragesCrossing(dataSerie, mode, lead, lag);
            
            if ~exist('riseThreshold','var'); riseThreshold = Settings.MovingAverageThreshold.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Settings.MovingAverageThreshold.FallThreshold; end
            
%             % If we only specify riseThreshold we suppose that the same
%             % value will be used for both thresholds
%             if exist('riseThreshold','var') && ~exist('fallThreshold','var')
%                 %riseThreshold = riseThreshold;
%                 fallThreshold = riseThreshold;
%             else
%                 if ~exist('riseThreshold','var'); riseThreshold = Settings.MovingAverageThreshold.RiseThreshold; end
%                 if ~exist('fallThreshold','var'); fallThreshold = Settings.MovingAverageThreshold.FallThreshold; end
%             end
            
            algoTrader.RiseThreshold = riseThreshold;
            algoTrader.FallThreshold = fallThreshold;
            
            % Events
            addlistener(algoTrader, 'RiseThreshold', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'FallThreshold', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
    end
    
    
end
