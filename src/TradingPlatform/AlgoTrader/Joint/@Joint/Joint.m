
classdef Joint < AlgoTrader & dynamicprops
    
    
    properties (GetAccess = public, SetAccess = public)
        
        InnerAlgoTrader
        
    end
    
    
    properties (GetAccess = protected, SetAccess = protected)
        
        DynamicProperties
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Joint(dataSerie, varargin)
            
            % All algoTraders share the same dataSerie
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            % Initialize Set
            algoTrader.InnerAlgoTrader = {};
            
            % Initialize Dynamic Properties
            algoTrader.DynamicProperties = [];
            
            % Add algoTrader set
            algoTrader.add(varargin{:});
            
            % Events
            addlistener(algoTrader, 'TrainingSet', 'PostSet', ...
                @(src, event) algoTrader.recursiveUpdate('TrainingSet', src, event));
            addlistener(algoTrader, 'TestSet', 'PostSet', ...
                @(src, event) algoTrader.recursiveUpdate('TestSet', src, event));
            addlistener(algoTrader, 'InitialFunds', 'PostSet', ...
                @(src, event) algoTrader.recursiveUpdate('InitialFunds', src, event));
            addlistener(algoTrader, 'InvestmentLimit', 'PostSet', ...
                @(src, event) algoTrader.recursiveUpdate('InvestmentLimit', src, event));
            addlistener(algoTrader, 'TradingCost', 'PostSet', ...
                @(src, event) algoTrader.recursiveUpdate('TradingCost', src, event));
            
            
        end
        
        
        add(algoTrader, varargin)
        
        remove(algoTrader, varargin)
        
        newObj = clone(this)
        
        
    end
    
    
    methods (Access = protected)
        
        % If an algoTrader is modified in the set stored within the
        % property InnerAlgoTrader, then, we cannot recompute Signal by
        % using InnerAlgoTrader as an Observable property and throwing an
        % event. We have to compute the signal each time that it is
        % requested. Redefining updateSignal is the way to have that
        % behaviour.
        updateSignal(algoTrader, src, event)
        
        recursiveUpdate(algoTrader, propertyName, src, event)
        
        updateDynamicProperties(algoTrader, src, event)
        
    end
    
    
    methods (Access = public, Abstract)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
