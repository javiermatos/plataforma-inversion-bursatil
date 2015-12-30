
classdef RelativeStrengthIndex < TradingEngineOscillator
    
    
    %%
    properties (GetAccess = public, SetAccess = public)
        
        Samples
        
        HighThreshold
        
        LowThreshold
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = RelativeStrengthIndex(fts, samples, highThreshold, lowThreshold)
            
            te = te@TradingEngineOscillator(fts);
            
            if ~exist('samples','var'); samples = Default.Samples; end
            te.Samples = samples;
            
            if ~exist('highThresold','var'); highThreshold = Default.HighThreshold; end
            te.HighThreshold = highThreshold;
            
            if ~exist('lowThreshold','var'); lowThreshold = Default.LowThreshold; end
            te.LowThreshold = lowThreshold;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        signal = computeSignal(te)
            
        
    end
    
    
    methods (Access = public, Static)
        
        te = optimum(fts, samplesDomain, highThresholdDomain, lowThresholdDomain)
        
    end
    
    
end
