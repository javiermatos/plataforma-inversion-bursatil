
classdef BollingerBands < Indicator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
        K
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = BollingerBands(dataSerie, samples, k)
            
            algoTrader = algoTrader@Indicator(dataSerie);
            
            if ~exist('samples','var'); samples = Default.BollingerBands.Samples; end
            if ~exist('k','var'); k = Default.BollingerBands.K; end
            
            algoTrader.Samples = samples;
            algoTrader.K = k;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'K', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [movingAverage, upperBand, lowerBand] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
