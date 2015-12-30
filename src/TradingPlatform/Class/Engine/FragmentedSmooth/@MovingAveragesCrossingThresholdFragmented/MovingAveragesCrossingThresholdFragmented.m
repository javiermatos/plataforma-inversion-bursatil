
classdef MovingAveragesCrossingThresholdFragmented < MovingAveragesCrossingFragmented
    
    
    %% RisingFallingThresholdArray, RisingThreshold, FallingThreshold
    properties (GetAccess = public, SetAccess = public)
        
        RiseFallThresholdDomain
        
        RiseThreshold
        
        FallThreshold
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAveragesCrossingThresholdFragmented( ...
                fts, ...
                mode, ...
                leadLagDomain, ...
                riseFallThresholdDomain, ...
                fragmentSize, ...
                jump, ...
                beginningIndex, ...
                smoothnessFunction, ...
                smoothnessSamples ...
                )
            
            if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
            if ~exist('jump','var'); jump = Default.Jump; end
            if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
            if ~exist('smoothnessFunction','var'); smoothnessFunction = Default.SmoothnessFunction; end
            if ~exist('smoothnessSamples','var'); smoothnessSamples = Default.SmoothnessSamples; end
            
            if ~exist('mode','var'); mode = Default.Mode; end
            if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomainF; end
            
            te = te@MovingAveragesCrossingFragmented(fts, mode, leadLagDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);
            
            if ~exist('riseFallThresholdDomain','var'); riseFallThresholdDomain = Default.RiseFallThresholdDomainF; end
            te.RiseFallThresholdDomain = riseFallThresholdDomain;
            
            % Initialize
            %te = te.computeParameters();
            
        end
        
        
        %% Methods
        
        te = computeParameters(te)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signalFragment = computeSignalFragment(te, startIndex, endIndex, fragmentNumber)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, mode, leadLagDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
        
    end
    
    
end
