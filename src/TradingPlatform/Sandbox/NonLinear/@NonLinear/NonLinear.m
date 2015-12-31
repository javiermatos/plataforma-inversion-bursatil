
classdef NonLinear < AlgoTrader
    
    
    methods (Access = public)
        
        
        function algoTrader = NonLinear(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            % Different Training/Test Sets
            TrainingSetInterval     = @(n) [floor(n*2/8) floor(n*5/8)];
            TestSetInterval         = @(n) [floor(n*5/8)+1 n];
            
            algoTrader.TrainingSet = TrainingSetInterval(algoTrader.DataSerie.Length);
            algoTrader.TestSet = TestSetInterval(algoTrader.DataSerie.Length);
            
        end
        
        
    end
    
    
    methods (Access = public, Abstract)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
