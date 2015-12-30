
classdef StochasticCrossing < Stochastic
    
    
    %% SamplesMovingAverage
    properties (GetAccess = public, SetAccess = public)
        
        Mode
        
        MovingAverageSamples
        
    end
    
    
    %% Public class methods
    methods
        
        
        %% Constructor
        function te = StochasticCrossing(fts, stochasticSamples, highThreshold, lowThreshold, mode, movingAverageSamples)
            
            if ~exist('stochasticSamples','var'); stochasticSamples = Default.StochasticSamples; end
            if ~exist('highThreshold','var'); highThreshold = Default.HighThreshold; end
            if ~exist('lowThreshold','var'); lowThreshold = Default.LowThreshold; end
            
            te = te@Stochastic(fts, stochasticSamples, highThreshold, lowThreshold);
            
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            if ~exist('movingAverageSamples','var'); movingAverageSamples = Default.MovingAverageSamples; end
            te.MovingAverageSamples = movingAverageSamples;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = optimum(fts, stochasticSamplesDomain, highThresholdDomain, lowThresholdDomain, modeDomain, movingAverageSamplesDomain)
        
    end
    
    
end
