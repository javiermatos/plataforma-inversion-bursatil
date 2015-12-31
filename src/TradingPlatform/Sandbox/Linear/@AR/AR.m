
classdef AR < Linear
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Order
        
        Method % 'burg', 'fb', 'gl', 'ls', 'yw'
        
        K
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = AR(dataSerie, order, method, k)
            
            algoTrader = algoTrader@Linear(dataSerie);
            
            if ~exist('order','var'); order = Default.AR.Order; end
            if ~exist('method','var'); method = Default.AR.Method; end
            if ~exist('k','var'); k = Default.AR.K; end
            
            algoTrader.Order = order;
            algoTrader.Method = method;
            algoTrader.K = k;
            
            % Events
            addlistener(algoTrader, 'Order', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Method', 'PostSet', @algoTrader.resetSignal);
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
