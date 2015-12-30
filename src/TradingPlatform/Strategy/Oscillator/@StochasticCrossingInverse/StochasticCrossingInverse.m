
classdef StochasticCrossingInverse < StochasticCrossing
    
    
    methods (Access = public)
        
        function algoTrader = StochasticCrossingInverse(dataSerie, samples, mode, crossingSamples)
            
            if ~exist('samples','var'); samples = Settings.StochasticCrossing.Samples; end
            if ~exist('mode','var'); mode = Settings.StochasticCrossing.Mode; end
            if ~exist('crossingSamples','var'); crossingSamples = Settings.StochasticCrossing.CrossingSamples; end
            
            algoTrader = algoTrader@StochasticCrossing(dataSerie, samples, mode, crossingSamples);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
