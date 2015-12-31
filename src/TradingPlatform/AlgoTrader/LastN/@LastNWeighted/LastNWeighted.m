
classdef LastNWeighted < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Weight
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastNWeighted(dataSerie, weight)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('weight','var'); weight = Settings.LastNWeighted.Weight; end
            
            algoTrader.Weight = weight;
            
            % Events
            addlistener(algoTrader, 'Weight', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        nPriceDifference = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
