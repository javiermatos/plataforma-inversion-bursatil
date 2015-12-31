
classdef ElitistIntersection < Intersection
    
    
    properties (GetAccess = public, SetAccess = public)
        
        Selection
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = ElitistIntersection(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@Intersection(dataSerie, varargin{:});
            
            algoTrader.Selection = ones(length(algoTrader.InnerAlgoTrader), 1);
            
        end
        
        
        add(algoTrader, varargin)
        
        remove(algoTrader, varargin)
        
        optimizeSelection(algoTrader, varargin)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
