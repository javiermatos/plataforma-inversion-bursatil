
classdef GARCH < NonLinear
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        K
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = GARCH(dataSerie, k)
            
            algoTrader = algoTrader@NonLinear(dataSerie);
            
            if ~exist('k','var'); k = Default.AR.K; end
            
            algoTrader.K = k;
            
            % Events
            addlistener(algoTrader, 'K', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        prediction = predict(algoTrader)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
