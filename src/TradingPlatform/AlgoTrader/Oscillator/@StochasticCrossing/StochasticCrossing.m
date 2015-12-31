
classdef StochasticCrossing < Stochastic
    
    
    methods (Access = public)
        
        function algoTrader = StochasticCrossing(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples)
            
            if ~exist('samples','var'); samples = Settings.StochasticCrossing.Samples; end
            if ~exist('highThresold','var'); riseThreshold = Settings.StochasticCrossing.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Settings.StochasticCrossing.FallThreshold; end
            if ~exist('mode','var'); mode = Settings.StochasticCrossing.Mode; end
            if ~exist('kSamples','var'); kSamples = Settings.StochasticCrossing.KSamples; end
            if ~exist('dSamples','var'); dSamples = Settings.StochasticCrossing.DSamples; end
            
            algoTrader = algoTrader@Stochastic(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples);
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
