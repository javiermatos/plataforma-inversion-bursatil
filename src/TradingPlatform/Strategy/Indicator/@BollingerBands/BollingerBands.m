
classdef BollingerBands < MovingAverage
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        K
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = BollingerBands(dataSerie, mode, samples, k)
            
            if ~exist('mode','var'); mode = Settings.BollingerBands.Mode; end
            if ~exist('samples','var'); samples = Settings.BollingerBands.Samples; end
            
            algoTrader = algoTrader@MovingAverage(dataSerie, mode, samples);
            
            if ~exist('k','var'); k = Settings.BollingerBands.K; end
            
            algoTrader.K = k;
            
            % Events
            addlistener(algoTrader, 'K', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
    end
    
    
end
