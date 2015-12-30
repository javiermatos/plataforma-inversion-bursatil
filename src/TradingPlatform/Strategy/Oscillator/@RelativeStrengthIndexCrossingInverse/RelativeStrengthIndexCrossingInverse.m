
classdef RelativeStrengthIndexCrossingInverse < RelativeStrengthIndexCrossing
    
    
    methods (Access = public)
        
        function algoTrader = RelativeStrengthIndexCrossingInverse(dataSerie, samples, mode, crossingSamples)
            
            if ~exist('samples','var'); samples = Settings.RelativeStrengthIndexCrossing.Samples; end
            if ~exist('mode','var'); mode = Settings.RelativeStrengthIndexCrossing.Mode; end
            if ~exist('crossingSamples','var'); crossingSamples = Settings.RelativeStrengthIndexCrossing.CrossingSamples; end
            
            algoTrader = algoTrader@RelativeStrengthIndexCrossing(dataSerie, samples, mode, crossingSamples);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
