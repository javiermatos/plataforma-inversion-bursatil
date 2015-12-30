
classdef MovingAverageDisplaced < MovingAverage
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Displacement
        
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
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
    end
    
    
end
