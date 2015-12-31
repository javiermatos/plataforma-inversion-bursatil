
classdef Stochastic < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
        RiseThreshold
        
        FallThreshold
        
        Mode
        
        KSamples
        
        DSamples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Stochastic(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.Stochastic.Samples; end
            if ~exist('highThresold','var'); riseThreshold = Settings.Stochastic.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Settings.Stochastic.FallThreshold; end
            if ~exist('mode','var'); mode = Settings.Stochastic.Mode; end
            if ~exist('kSamples','var'); kSamples = Settings.Stochastic.KSamples; end
            if ~exist('dSamples','var'); dSamples = Settings.Stochastic.DSamples; end
            
            algoTrader.Samples = samples;
            algoTrader.RiseThreshold = riseThreshold;
            algoTrader.FallThreshold = fallThreshold;
            algoTrader.Mode = mode;
            algoTrader.KSamples = kSamples;
            algoTrader.DSamples = dSamples;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'RiseThreshold', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'FallThreshold', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'KSamples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'DSamples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [stochastic, k, d] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
