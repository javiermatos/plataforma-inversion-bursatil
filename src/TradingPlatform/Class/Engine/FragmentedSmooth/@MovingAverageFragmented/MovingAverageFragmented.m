
classdef MovingAverageFragmented < TradingEngineFragmentedSmooth
    
    
    %% MaximumSamples, Samples
    properties (GetAccess = public, SetAccess = public)
        
        SamplesDomain
        
        Mode
        
        Samples
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAverageFragmented( ...
                fts, ...
                mode, ...
                samplesDomain, ...
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
            
            te = te@TradingEngineFragmentedSmooth(fts, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);
            
            if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomainF; end
            te.SamplesDomain = samplesDomain;
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            % Initialize
            %te = te.computeParameters();
            
        end
        
        
        %% Methods
        
        te = computeParameters(te)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signalFragment = computeSignalFragment(te, startIndex, endIndex, fragmentNumber)
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, mode, samplesDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
        
    end
    
    
end
