
classdef Skeleton < AlgoTraderParent
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Variable1
        
        Variable2
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Skeleton(dataSerie, variable1, variable2)
            
            if ~exist('variable','var'); variable1 = some_value1; end
            
            algoTrader = algoTrader@AlgoTraderParent(dataSerie, variable1);
            
            if ~exist('variable2','var'); variable2 = some_value2; end
            
            algoTrader.Variable2 = variable2;
            
            % Events
            addlistener(algoTrader, 'Variable2', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
