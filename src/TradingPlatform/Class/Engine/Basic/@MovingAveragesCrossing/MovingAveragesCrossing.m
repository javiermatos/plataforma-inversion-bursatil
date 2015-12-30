
classdef MovingAveragesCrossing < TradingEngine
    
    
    %% Lead, Lag
    properties (GetAccess = public, SetAccess = public)
        
        Mode    % Mode
        
        Lead    % Lead value
        
        Lag     % Lag value
        
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
        function te = MovingAveragesCrossing(fts, mode, lead, lag)
            
            te = te@TradingEngine(fts);
            
            if ~exist('mode','var'); mode = Default.Mode; end
            te.Mode = mode;
            
            if ~exist('lead','var'); lead = Default.Lead; end
            te.Lead = lead;
            
            if ~exist('lag','var'); lag = Default.Lag; end
            te.Lag = lag;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, modeDomain, leadLagDomain)
        
    end
    
    
end
