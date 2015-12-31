
classdef Indicator < AlgoTrader
    
    
    methods (Access = public)
        
        function algoTrader = Indicator(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
        end
        
    end
    
    
    methods (Access = public, Abstract)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
