
classdef ThreeMovingAverages < Indicator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Fast
        
        Middle
        
        Slow
        
    end
    
    
    %% LeadLag
    properties (Dependent = true)
        
        FastMiddleSlow  % To use with optimization functions
        
    end
    
    methods
        
        % LeadLag SET
        function set.FastMiddleSlow(algoTrader, FastMiddleSlow)
            algoTrader.Fast = FastMiddleSlow(1);
            algoTrader.Middle = FastMiddleSlow(2);
            algoTrader.Slow = FastMiddleSlow(3);
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = ThreeMovingAverages(dataSerie, mode, fast, middle, slow)
            
            algoTrader = algoTrader@Indicator(dataSerie);
            
            if ~exist('mode','var'); mode = 'e'; end %Settings.MovingAveragesCrossing.Mode; end
            if ~exist('fast','var'); fast = 5; end %Settings.MovingAveragesCrossing.Lead; end
            if ~exist('middle','var'); middle = 21; end %Settings.MovingAveragesCrossing.Lag; end
            if ~exist('slow','var'); slow = 63; end %Settings.MovingAveragesCrossing.Lag; end
            
            algoTrader.Mode = mode;
            algoTrader.Fast = fast;
            algoTrader.Middle = middle;
            algoTrader.Slow = slow;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Fast', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Middle', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Slow', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [fastMovingAverage, middleMovingAverage, slowMovingAverage] = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
