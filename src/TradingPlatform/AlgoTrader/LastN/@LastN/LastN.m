
classdef LastN < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastN(dataSerie, samples)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('samples','var'); samples = Default.LastN.Samples; end
            
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        nPriceDifference = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
