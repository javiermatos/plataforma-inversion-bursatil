
classdef LastNTrendsWeighted < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Weight
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastNTrendsWeighted(dataSerie, weight)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('weight','var'); weight = Settings.LastNTrendsWeighted.Weight; end
            
            algoTrader.Weight = weight;
            
            % Events
            addlistener(algoTrader, 'Weight', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [nRisingTrends, nFallingTrends] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
