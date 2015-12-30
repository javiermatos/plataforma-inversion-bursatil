
classdef Joint < AlgoTrader & dynamicprops
    
    
    properties (GetAccess = public, SetAccess = public)
        
        Set
        
    end
    
    
    properties (GetAccess = public, SetAccess = public)
        
        DynamicProperties
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Joint(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            % Initialize Set
            algoTrader.Set = {};
            
            % Initialize Dynamic Properties
            algoTrader.DynamicProperties = [];
            
            % Add algoTrader set
            algoTrader.add(varargin{:});
            
            % Events
            addlistener(algoTrader, 'InitialIndexRatio', 'PostSet', @algoTrader.recursiveInitialIndexRatio);
            addlistener(algoTrader, 'SplitIndexRatio', 'PostSet', @algoTrader.recursiveSplitIndexRatio);
            
        end
        
        
        add(algoTrader, varargin)
        
        remove(algoTrader, varargin)
        
        % optimize(algoTrader, varargin)
        
        fig = plotSearchSpace(algoTrader, varargin)
        
        newObj = clone(this)
        
    end
    
    
    methods (Access = protected)
        
        % If an algoTrader is modified in the set we cannot recompute
        % Signal by using Set as an Observable property and throwing an
        % event. We have to compute the signal each time that it is
        % requested. Redefining updateSignal is the way to have that
        % behaviour.
        updateSignal(algoTrader, src, event)
        
        recursiveInitialIndexRatio(algoTrader, src, event)
        
        recursiveSplitIndexRatio(algoTrader, src, event)
        
        updateDynamicProperties(algoTrader, src, event)
        
        % fitnessValue = fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray)
        
    end
    
    
    methods (Access = public, Abstract)
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
