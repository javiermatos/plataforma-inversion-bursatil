
classdef AverageDirectionalIndex < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = AverageDirectionalIndex(dataSerie, mode, samples)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('mode','var'); mode = Settings.AverageDirectionalIndex.Mode; end
            if ~exist('samples','var'); samples = Settings.AverageDirectionalIndex.Samples; end
            
            algoTrader.Mode = mode;
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [plusDirectionalMovement, minusDirectionalMovement, directionalMovementIndex, averageDirectionalIndex] ...
            = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
