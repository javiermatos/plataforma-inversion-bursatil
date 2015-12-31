
classdef RelativeStrengthIndexCrossing < RelativeStrengthIndex
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        CMode
        
        CSamples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = RelativeStrengthIndexCrossing(dataSerie, samples, cMode, cSamples)
            
            if ~exist('samples','var'); samples = Default.RelativeStrengthIndexCrossing.Samples; end
            
            algoTrader = algoTrader@RelativeStrengthIndex(dataSerie, samples);
            
            if ~exist('cMode','var'); cMode = Default.RelativeStrengthIndexCrossing.CMode; end
            if ~exist('cSamples','var'); cSamples = Default.RelativeStrengthIndexCrossing.CSamples; end
            
            algoTrader.CMode = cMode;
            algoTrader.CSamples = cSamples;
            
            % Events
            addlistener(algoTrader, 'CMode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'CSamples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [relativeStrengthIndex, movingAverage] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
