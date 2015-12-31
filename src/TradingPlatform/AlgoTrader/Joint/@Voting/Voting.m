
classdef Voting < Joint
    
    
    properties (GetAccess = public, SetAccess = public)
        
        Ratio
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Voting(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@Joint(dataSerie, varargin{:});
            
            %algoTrader.Votes = round(length(algoTrader.InnerAlgoTrader)*Settings.Majority.Ratio);
            algoTrader.Ratio = Settings.Voting.Ratio;
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
