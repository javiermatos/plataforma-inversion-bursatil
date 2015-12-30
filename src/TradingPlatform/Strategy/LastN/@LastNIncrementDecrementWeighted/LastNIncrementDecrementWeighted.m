
classdef LastNIncrementDecrementWeighted < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Weight
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastNIncrementDecrementWeighted(dataSerie, weight)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('weight','var'); weight = Settings.LastNIncrementDecrementWeighted.Weight; end
            
            algoTrader.Weight = weight;
            
            % Events
            addlistener(algoTrader, 'Weight', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
