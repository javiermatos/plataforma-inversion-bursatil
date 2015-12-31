
classdef StochasticStateMachine < Stochastic
    
    
    methods (Access = public)
        
        function algoTrader = StochasticStateMachine(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples)
            
            if ~exist('samples','var'); samples = Default.StochasticStateMachine.Samples; end
            if ~exist('highThresold','var'); riseThreshold = Default.StochasticStateMachine.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Default.StochasticStateMachine.FallThreshold; end
            if ~exist('mode','var'); mode = Default.StochasticStateMachine.Mode; end
            if ~exist('kSamples','var'); kSamples = Default.StochasticStateMachine.KSamples; end
            if ~exist('dSamples','var'); dSamples = Default.StochasticStateMachine.DSamples; end
            
            algoTrader = algoTrader@Stochastic(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples);
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
