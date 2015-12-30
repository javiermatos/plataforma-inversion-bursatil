
classdef BollingerBandsInverse < BollingerBands
    
    
    methods (Access = public)
        
        function algoTrader = BollingerBandsInverse(dataSerie, mode, samples, k)
            
            if ~exist('mode','var'); mode = Settings.BollingerBands.Mode; end
            if ~exist('samples','var'); samples = Settings.BollingerBands.Samples; end
            if ~exist('k','var'); k = Settings.BollingerBands.K; end
            
            algoTrader = algoTrader@BollingerBands(dataSerie, mode, samples, k);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
