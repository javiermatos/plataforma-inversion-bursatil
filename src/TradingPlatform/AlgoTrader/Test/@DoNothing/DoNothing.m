
classdef DoNothing < AlgoTrader
    
    methods (Access = public)
        
        function algoTrader = DoNothing(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
        end
        
    end
    
    methods (Access = public)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
end
