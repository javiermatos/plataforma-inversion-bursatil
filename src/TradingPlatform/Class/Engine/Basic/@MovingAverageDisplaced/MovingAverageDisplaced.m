
classdef MovingAverageDisplaced < MovingAverage
    
    
    %% Displacement
    properties (GetAccess = public, SetAccess = public)
        
        Displacement    % Displacement of the signal
        
    end
    
    methods
        
        % Displacement SET
        function te = set.Displacement(te, Displacement)
            if Displacement < 0
                error('Time travelling?, maybe in next release. Try using values in [0, Inf).');
            end
            te.Displacement = Displacement;
        end
        
    end
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = MovingAverageDisplaced(fts, mode, samples, displacement)
            
            if ~exist('mode','var'); mode = Default.Mode; end
            if ~exist('samples','var'); samples = Default.Samples; end
            
            te = te@MovingAverage(fts, mode, samples);
            
            if ~exist('displacement','var'); displacement = Default.Displacement; end
            te.Displacement = displacement;
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, varargin)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = initialize(fts, modeDomain, samplesDomain, displacementDomain)
        
    end
    
    
end
