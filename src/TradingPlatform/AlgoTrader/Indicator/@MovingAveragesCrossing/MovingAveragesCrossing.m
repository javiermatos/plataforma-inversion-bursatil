
classdef MovingAveragesCrossing < Indicator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Lead
        
        Lag
        
    end
    
    
%     %% LeadLag
%     properties (Dependent = true)
%         
%         LeadLag  % To use with optimization functions
%         
%     end
%     
%     methods
%         
%         % LeadLag SET
%         function set.LeadLag(algoTrader, LeadLag)
%             algoTrader.Lead = LeadLag(1);
%             algoTrader.Lag = LeadLag(2);
%         end
%         
%     end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAveragesCrossing(dataSerie, mode, lead, lag)
            
            algoTrader = algoTrader@Indicator(dataSerie);
            
            if ~exist('mode','var'); mode = Settings.MovingAveragesCrossing.Mode; end
            if ~exist('lead','var'); lead = Settings.MovingAveragesCrossing.Lead; end
            if ~exist('lag','var'); lag = Settings.MovingAveragesCrossing.Lag; end
            
            algoTrader.Mode = mode;
            algoTrader.Lead = lead;
            algoTrader.Lag = lag;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Lead', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Lag', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [leadMovingAverage, lagMovingAverage] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
