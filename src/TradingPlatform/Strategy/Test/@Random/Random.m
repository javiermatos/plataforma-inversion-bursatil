
classdef Random < AlgoTrader
    
    methods (Access = public)
        
        function algoTrader = Random(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
