
classdef RelativeStrengthIndex < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
        RiseThreshold
        
        FallThreshold
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = RelativeStrengthIndex(dataSerie, samples, riseThreshold, fallThreshold)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.RelativeStrengthIndex.Samples; end
            if ~exist('highThresold','var'); riseThreshold = Settings.RelativeStrengthIndex.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Settings.RelativeStrengthIndex.FallThreshold; end
            
            algoTrader.Samples = samples;
            algoTrader.RiseThreshold = riseThreshold;
            algoTrader.FallThreshold = fallThreshold;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'RiseThreshold', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'FallThreshold', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        relativeStrengthIndex = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
