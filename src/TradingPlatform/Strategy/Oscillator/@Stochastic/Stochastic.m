
classdef Stochastic < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
        HighThreshold
        
        LowThreshold
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Stochastic(dataSerie, samples, highThreshold, lowThreshold)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.Stochastic.Samples; end
            if ~exist('highThresold','var'); highThreshold = Settings.Stochastic.HighThreshold; end
            if ~exist('lowThreshold','var'); lowThreshold = Settings.Stochastic.LowThreshold; end
            
            algoTrader.Samples = samples;
            algoTrader.HighThreshold = highThreshold;
            algoTrader.LowThreshold = lowThreshold;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'HighThreshold', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'LowThreshold', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, initIndex, endIndex)
        
    end
    
    
end
