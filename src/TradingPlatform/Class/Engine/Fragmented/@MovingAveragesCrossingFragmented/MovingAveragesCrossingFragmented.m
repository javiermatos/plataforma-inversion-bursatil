
classdef MovingAveragesCrossingFragmented < TradingEngineFragmented
    
    
    %% MaximumSamples, Samples
    properties (GetAccess = public, SetAccess = protected)
        
        LeadLagDomain
        
        Mode
        
        Lead
        
        Lag
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAveragesCrossingFragmented( ...
                fts, ...
                mode, ...
                leadLagDomain, ...
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
            
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomainF; end
            te.LeadLagDomain = leadLagDomain;
            
            % Initialize
            %te = te.initialize();
            
        end
        
        
        %% Methods
        
        te = initialize(te)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signalFragment = computeSignalFragment(te, fragmentNumber, startIndex, endIndex)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = launch(fts, mode, leadLagDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
        
    end
    
    
end
