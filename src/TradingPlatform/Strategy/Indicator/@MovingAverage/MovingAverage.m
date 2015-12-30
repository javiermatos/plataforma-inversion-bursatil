
classdef MovingAverage < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAverage(dataSerie, mode, samples)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('mode','var'); mode = Settings.MovingAverage.Mode; end
            if ~exist('samples','var'); samples = Settings.MovingAverage.Samples; end
            
            algoTrader.Mode = mode;
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
    end
    
    
end
