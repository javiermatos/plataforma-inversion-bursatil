
classdef MovingAverageThreshold < MovingAverage
    
    
    %% RiseThreshold, FallThreshold
    properties (GetAccess = public, SetAccess = public)
        
        RiseThreshold       % Threshold that leading average must satisfy
                            % when crossing lagging when rising
        
        FallThreshold       % Threshold that leading average must satisfy
                            % when crossing lagging when falling
        
    end
    
    
    %% RiseFallThreshold
    properties (Dependent = true)
        
        RiseFallThreshold  % To use with exhaustive* functions
        
    end
    
    methods
        
        % RiseFallThreshold GET
        function RiseFallThreshold = get.RiseFallThreshold(te)
            RiseFallThreshold = [te.RiseThreshold, te.FallThreshold];
        end
        
        % RiseFallThreshold SET
        function te = set.RiseFallThreshold(te, RiseFallThreshold)
            te.RiseThreshold = RiseFallThreshold(1);
            te.FallThreshold = RiseFallThreshold(2);
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAverageThreshold(fts, mode, samples, riseThreshold, fallThreshold)
            
            if ~exist('mode','var'); mode = Default.Mode; end
            if ~exist('samples','var'); samples = Default.Samples; end
            
            te = te@MovingAverage(fts, mode, samples);
            
            if ~exist('riseThreshold','var'); riseThreshold = Default.RiseThreshold; end
            te.RiseThreshold = riseThreshold;
            
            if ~exist('fallThreshold','var'); fallThreshold = Default.FallThreshold; end
            te.FallThreshold = fallThreshold;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, modeDomain, samplesDomain, riseFallThresholdDomain)
        
    end
    
    
end
