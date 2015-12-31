
classdef ARMA < Linear
    
    
    % Orders
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Na
        
        Nc
        
        Method % 'Auto', 'gn', 'gna', 'lm', 'lsqnonlin'
        
        K
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = ARMA(dataSerie, na, nc, method, k)
            
            algoTrader = algoTrader@Linear(dataSerie);
            
            if ~exist('na','var'); na = Default.ARMA.Na; end
            if ~exist('nc','var'); nc = Default.ARMA.Nc; end
            if ~exist('method','var'); method = Default.ARMA.Method; end
            if ~exist('k','var'); k = Default.ARMA.K; end
            
            algoTrader.Na = na;
            algoTrader.Nc = nc;
            algoTrader.Method = method;
            algoTrader.K = k;
            
            % Events
            addlistener(algoTrader, 'Na', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Nc', 'PostSet', @algoTrader.resetSignal);
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
