
classdef MovingAverageThresholdFragmented < MovingAverageFragmented
    
    
    %% RiseFallThresholdDomain, RiseThreshold, FallThreshold
    properties (GetAccess = public, SetAccess = protected)
        
        RiseFallThresholdDomain
        
        RiseThreshold
        
        FallThreshold
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAverageThresholdFragmented( ...
                fts, ...
                mode, ...
                samplesDomain, ...
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
            if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomainF; end
            
            te = te@MovingAverageFragmented(fts, mode, samplesDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);
            
            if ~exist('riseFallThresholdDomain','var'); riseFallThresholdDomain = Default.RiseFallThresholdDomainF; end
            te.RiseFallThresholdDomain = riseFallThresholdDomain;
            
            % Initialize
            %te = te.initialize();
            
        end
        
        
        %% Methods
        
        te = initialize(te)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signalFragment = computeSignalFragment(te, fragmentNumber, startIndex, endIndex)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = launch(fts, mode, samplesDomain, riseFallThresholdDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
        
    end
    
    
end
