
classdef FakeOptimum < AlgoTrader
    
    methods (Access = public)
        
        function algoTrader = FakeOptimum(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
