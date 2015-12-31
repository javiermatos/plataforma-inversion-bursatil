
classdef Fragmented < AlgoTrader
    
    properties (GetAccess = public, SetAccess = public, GetObservable)
        
        Fragment
        
    end
    
    
    properties (GetAccess = private, SetAccess = private)
        
        InnerAlgoTrader
        
    end
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        TrainingSetSize
        
        TestSetSize
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Fragmented(innerAlgoTrader, trainingSetSize, testSetSize)
            
            dataSerie = innerAlgoTrader.DataSerie;
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('trainingSetSize','var'); trainingSetSize = Default.Fragmented.TrainingSetSize; end
            if ~exist('testSetSize','var'); testSetSize = Default.Fragmented.TestSetSize; end
            
            algoTrader.InnerAlgoTrader = innerAlgoTrader.clone();
            algoTrader.Fragment = [];
            algoTrader.TrainingSetSize = trainingSetSize;
            algoTrader.TestSetSize = testSetSize;
            
            % Correct TrainingSet and TestSet
            %algoTrader.TrainingSet = [trainingSetSize+1 dataSerie.Length];
            %algoTrader.TestSet = [trainingSetSize+1 dataSerie.Length];
            
            % Events
            addlistener(algoTrader, 'TestSetSize', 'PostSet', @algoTrader.resetFragment);
            addlistener(algoTrader, 'TrainingSetSize', 'PostSet', @algoTrader.resetFragment);
            
            addlistener(algoTrader, 'Fragment', 'PreGet', @algoTrader.updateFragment);
            
        end
        
        
        values = wideGet(algoTrader, name)
        
        wideSet(algoTrader, name, values)
        
        optimize(algoTrader, varargin)
        
        [minProfitLoss, maxProfitLoss, meanProfitLoss, stdProfitLoss] ...
            = fitnessStatistics(algoTrader, varargin)
        
        fig = plotSearchSpace(algoTrader, varargin)
        
        fig = plotSearchSpace123(algoTrader, varargin)
        
        newObj = clone(this)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        % If an algoTrader is modified in the set we cannot recompute
        % Signal by using Fragment as an Observable property and throwing
        % an event. We have to compute the signal each time that it is
        % requested. Redefining updateSignal is the way to have that
        % behaviour.
        updateSignal(algoTrader, src, event)
        
        resetFragment(algoTrader, src, event)
        
        updateFragment(algoTrader, src, event)
        
    end
    
end
