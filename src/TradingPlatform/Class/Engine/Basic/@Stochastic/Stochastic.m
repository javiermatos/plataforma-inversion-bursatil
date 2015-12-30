
classdef Stochastic < TradingEngineOscillator
    
    
    %% Samples, HighThreshold, LowThreshold
    properties (GetAccess = public, SetAccess = public)
        
        StochasticSamples
        
        HighThreshold
        
        LowThreshold
        
    end
    
    
    %% Public class methods
    methods
        
        
        %% Constructor
        function te = Stochastic(fts, stochasticSamples, highThreshold, lowThreshold)
            
            te = te@TradingEngineOscillator(fts);
            
            if ~exist('stochasticSamples','var'); stochasticSamples = Default.StochasticSamples; end
            te.StochasticSamples = stochasticSamples;
            
            if ~exist('highThreshold','var'); highThreshold = Default.HighThreshold; end
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
        
        te = initialize(fts, stochasticSamplesDomain, highThresholdDomain, lowThresholdDomain)
        
    end
    
    
end
