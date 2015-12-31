
classdef StochasticCrossing < Stochastic
    
    
    methods (Access = public)
        
        function algoTrader = StochasticCrossing(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples)
            
            if ~exist('samples','var'); samples = Default.StochasticCrossing.Samples; end
            if ~exist('highThresold','var'); riseThreshold = Default.StochasticCrossing.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Default.StochasticCrossing.FallThreshold; end
            if ~exist('mode','var'); mode = Default.StochasticCrossing.Mode; end
            if ~exist('kSamples','var'); kSamples = Default.StochasticCrossing.KSamples; end
            if ~exist('dSamples','var'); dSamples = Default.StochasticCrossing.DSamples; end
            
            algoTrader = algoTrader@Stochastic(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples);
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
