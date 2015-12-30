
classdef MovingAveragesCrossingThreshold < MovingAveragesCrossing
    
    
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
        function te = MovingAveragesCrossingThreshold(fts, mode, lead, lag, riseThreshold, fallThreshold)
            
            if ~exist('mode','var'); mode = Default.Mode; end
            if ~exist('lead','var'); lead = Default.Lead; end
            if ~exist('lag','var'); lag = Default.Lag; end
            
            te = te@MovingAveragesCrossing(fts, mode, lead, lag);
            
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
        
        te = optimum(fts, modeDomain, leadLagDomain, riseFallThresholdDomain)
        
    end
    
    
end
