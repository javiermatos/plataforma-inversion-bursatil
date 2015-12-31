
classdef MomentumCrossing < Momentum
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = MomentumCrossing(dataSerie, delay, mode, samples)
            
            if ~exist('delay','var'); delay = Default.MomentumCrossing.Delay; end
            
            algoTrader = algoTrader@Momentum(dataSerie, delay);
            
            if ~exist('mode','var'); mode = Default.MomentumCrossing.Mode; end
            if ~exist('samples','var'); samples = Default.MomentumCrossing.Samples; end
            
            algoTrader.Mode = mode;
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [momentum, movingAverage] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
