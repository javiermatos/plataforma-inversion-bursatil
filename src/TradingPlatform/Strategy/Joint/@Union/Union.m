
classdef Union < Joint
    
    
    properties (GetAccess = public, SetAccess = public)
        
        Votes
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Union(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@Joint(dataSerie, varargin{:});
            
            algoTrader.Votes = round(length(algoTrader.Set)*Settings.Union.VotesRatio);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
