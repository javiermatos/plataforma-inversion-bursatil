
classdef FakeOptimum < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Foresee
        
    end
    
    methods
        
        % Foresee SET
        function set.Foresee(algoTrader, Foresee)
            if Foresee < 0
                error('Error: negative foresee value is not allowed');
            else
                algoTrader.Foresee = Foresee;
            end
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = FakeOptimum(dataSerie, foresee)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('foresee','var'); foresee = Settings.FakeOptimum.Foresee; end
            
            algoTrader.Foresee = foresee;
            
            % Events
            addlistener(algoTrader, 'Foresee', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        fig = plotSeriePositionProfitLoss(algoTrader, setSelector, rangeInit, rangeEnd)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
