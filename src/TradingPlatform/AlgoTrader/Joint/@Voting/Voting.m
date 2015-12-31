
classdef Voting < Joint
    
    
    properties (GetAccess = public, SetAccess = public)
        
        Ratio
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Voting(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@Joint(dataSerie, varargin{:});
            
            %algoTrader.Votes = round(length(algoTrader.InnerAlgoTrader)*Default.Majority.Ratio);
            algoTrader.Ratio = Default.Voting.Ratio;
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
