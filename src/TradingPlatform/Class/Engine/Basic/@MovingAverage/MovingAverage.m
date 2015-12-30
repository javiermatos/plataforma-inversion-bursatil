
classdef MovingAverage < TradingEngine
    
    
    %% Mode
    properties (GetAccess = public, SetAccess = public)
        
        Mode     % Number of samples
        
        Samples
        
    end
    
    methods
        
        % Mode SET
        function te = set.Mode(te, Mode)
            te.Mode = Mode;
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAverage(fts, mode, samples)
            
            te = te@TradingEngine(fts);
            
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            if ~exist('samples','var'); samples = Default.Samples; end
            te.Samples = samples;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, modeDomain, samplesDomain)
        
    end
    
    
end
