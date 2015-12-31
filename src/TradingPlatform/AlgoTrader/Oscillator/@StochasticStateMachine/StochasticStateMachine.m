
classdef StochasticStateMachine < Stochastic
    
    
    methods (Access = public)
        
        function algoTrader = StochasticStateMachine(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples)
            
            if ~exist('samples','var'); samples = Settings.StochasticStateMachine.Samples; end
            if ~exist('highThresold','var'); riseThreshold = Settings.StochasticStateMachine.RiseThreshold; end
            if ~exist('fallThreshold','var'); fallThreshold = Settings.StochasticStateMachine.FallThreshold; end
            if ~exist('mode','var'); mode = Settings.StochasticStateMachine.Mode; end
            if ~exist('kSamples','var'); kSamples = Settings.StochasticStateMachine.KSamples; end
            if ~exist('dSamples','var'); dSamples = Settings.StochasticStateMachine.DSamples; end
            
            algoTrader = algoTrader@Stochastic(dataSerie, samples, riseThreshold, fallThreshold, mode, kSamples, dSamples);
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
