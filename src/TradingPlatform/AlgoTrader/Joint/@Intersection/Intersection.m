
classdef Intersection < Joint
    
    
    methods (Access = public)
        
        function algoTrader = Intersection(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@Joint(dataSerie, varargin{:});
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
