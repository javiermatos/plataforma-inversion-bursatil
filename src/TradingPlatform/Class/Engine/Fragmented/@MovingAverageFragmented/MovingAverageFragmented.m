
classdef MovingAverageFragmented < TradingEngineFragmented
    
    
    %% MaximumSamples, Samples
    properties (GetAccess = public, SetAccess = protected)
        
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
            
            te = te@TradingEngineFragmented(fts, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);
            
            if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomainF; end
            te.SamplesDomain = samplesDomain;
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            % Initialize
            %te = te.initialize();
            
        end
        
        
        %% Methods
        
        te = initialize(te)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signalFragment = computeSignalFragment(te, fragmentNumber, startIndex, endIndex)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = launch(fts, mode, samplesDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
        
    end
    
    
end
