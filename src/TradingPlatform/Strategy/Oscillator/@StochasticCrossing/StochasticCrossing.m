
classdef StochasticCrossing < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
        Mode
        
        CrossingSamples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = StochasticCrossing(dataSerie, samples, mode, crossingSamples)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.StochasticCrossing.Samples; end
            if ~exist('mode','var'); mode = Settings.StochasticCrossing.Mode; end
            if ~exist('crossingSamples','var'); crossingSamples = Settings.StochasticCrossing.CrossingSamples; end
            
            algoTrader.Samples = samples;
            algoTrader.Mode = mode;
            algoTrader.CrossingSamples = crossingSamples;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'CrossingSamples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, initIndex, endIndex)
        
    end
    
    
end
