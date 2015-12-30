
classdef MovingAveragesCrossingFragmented < TradingEngineFragmentedSmooth
    
    
    %% MaximumSamples, Samples
    properties (GetAccess = public, SetAccess = public)
        
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
            
            te = te@TradingEngineFragmentedSmooth(fts, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);
            
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomainF; end
            te.LeadLagDomain = leadLagDomain;
            
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
