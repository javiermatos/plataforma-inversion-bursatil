
classdef MovingAverage < Indicator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAverage(dataSerie, mode, samples)
            
            algoTrader = algoTrader@Indicator(dataSerie);
            
            if ~exist('mode','var'); mode = Default.MovingAverage.Mode; end
            if ~exist('samples','var'); samples = Default.MovingAverage.Samples; end
            
            algoTrader.Mode = mode;
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        movingAverage = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
