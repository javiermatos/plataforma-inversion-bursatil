
classdef BollingerBands < MovingAverage
    
    
    %% K
    properties
        
        K
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = BollingerBands(fts, mode, samples, k)
            
            if ~exist('mode','var'); mode = Default.Mode; end
            if ~exist('samples','var'); samples = Default.Samples; end
            
            te = te@MovingAverage(fts, mode, samples);
            
            if ~exist('k','var'); k = Default.K; end
            te.K = k;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, modeDomain, samplesDomain, KDomain)
        
    end
    
    
end
