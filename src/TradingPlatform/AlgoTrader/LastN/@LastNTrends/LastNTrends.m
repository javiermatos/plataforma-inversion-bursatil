
classdef LastNTrends < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastNTrends(dataSerie, samples)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.LastNTrends.Samples; end
            
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [nRisingTrends, nFallingTrends] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
