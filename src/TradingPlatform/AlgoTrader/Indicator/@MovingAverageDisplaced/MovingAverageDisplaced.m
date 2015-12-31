
classdef MovingAverageDisplaced < MovingAverage
    
    
    %% Displacement
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Displacement
        
    end
    
    methods
        
        % Displacement SET
        function set.Displacement(algoTrader, Displacement)
            if Displacement < 0
                error('Error: negative displacement is not allowed');
            else
                algoTrader.Displacement = Displacement;
            end
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAverageDisplaced(dataSerie, mode, samples, displacement)
            
            if ~exist('mode','var'); mode = Settings.MovingAverageDisplaced.Mode; end
            if ~exist('samples','var'); samples = Settings.MovingAverageDisplaced.Samples; end
            
            algoTrader = algoTrader@MovingAverage(dataSerie, mode, samples);
            
            if ~exist('displacement','var'); displacement = Settings.MovingAverageDisplaced.Displacement; end
            
            algoTrader.Displacement = displacement;
            
            % Events
            addlistener(algoTrader, 'Displacement', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        movingAverageDisplaced = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
