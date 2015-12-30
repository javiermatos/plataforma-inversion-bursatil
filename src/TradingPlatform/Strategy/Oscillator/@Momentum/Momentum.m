
classdef Momentum < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Delay
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Momentum(dataSerie, delay)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('delay','var'); delay = Settings.Momentum.Delay; end
            
            algoTrader.Delay = delay;
            
            % Events
            addlistener(algoTrader, 'Delay', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, initIndex, endIndex)
        
    end
    
    
end
