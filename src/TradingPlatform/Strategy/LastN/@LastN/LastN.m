
classdef LastN < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastN(dataSerie, samples)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.LastN.Samples; end
            
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
