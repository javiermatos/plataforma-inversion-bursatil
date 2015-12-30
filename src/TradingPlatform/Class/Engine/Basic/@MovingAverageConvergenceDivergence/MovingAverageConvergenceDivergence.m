
classdef MovingAverageConvergenceDivergence < TradingEngineOscillator
    
    
    %% 
    properties (GetAccess = public, SetAccess = public)
        
        Mode
        
        Lead
        
        Lag
        
        Samples
        
    end
    
    
    %% LeadLag
    properties (Dependent = true)
        
        LeadLag  % To use with exhaustive* functions
        
    end
    
    methods
        
        % LeadLag GET
        function LeadLag = get.LeadLag(te)
            LeadLag = [te.Lead te.Lag];
        end
        
        % LeadLag SET
        function te = set.LeadLag(te, LeadLag)
            te.Lead = LeadLag(1);
            te.Lag = LeadLag(2);
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAverageConvergenceDivergence(fts, mode, lead, lag, samples)
            
            te = te@TradingEngineOscillator(fts);
            
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            if ~exist('lead','var'); lead = Default.Lead; end
            te.Lead = lead;
            
            if ~exist('lag','var'); lag = Default.Lag; end
            te.Lag = lag;
            
            if ~exist('samples','var'); samples = Default.Samples; end
            te.Samples = samples;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, modeDomain, leadLagDomain, samplesDomain)
        
    end
    
    
end
