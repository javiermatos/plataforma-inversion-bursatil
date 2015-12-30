
classdef Fragmented < AlgoTrader
    
    properties (GetAccess = public, SetAccess = public, GetObservable)
        
        Fragment
        
    end
    
    
    properties (GetAccess = private, SetAccess = private)
        
        AlgoTraderBase
        
    end
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Size
        
        Jump
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Fragmented(algoTraderBase, size, jump)
            
            algoTrader = algoTrader@AlgoTrader(algoTraderBase.DataSerie);
            
            algoTrader.AlgoTraderBase = algoTraderBase.clone();
            
            if ~exist('size','var'); size = Settings.Fragmented.Size; end
            if ~exist('jump','var'); jump = Settings.Fragmented.Jump; end
            
            algoTrader.Size = size;
            algoTrader.Jump = jump;
            
            % Correct SplitIndex
            % algoTrader.SplitIndex = min(algoTrader.InitialIndex+algoTrader.Jump, algoTrader.DataSerie.Length);
            
            % Events
            addlistener(algoTrader, 'Size', 'PostSet', @algoTrader.resetFragment);
            addlistener(algoTrader, 'Jump', 'PostSet', @algoTrader.resetFragment);
            addlistener(algoTrader, 'InitialIndexRatio', 'PostSet', @algoTrader.resetFragment);
            addlistener(algoTrader, 'SplitIndexRatio', 'PostSet', @algoTrader.resetFragment);
            
            addlistener(algoTrader, 'Fragment', 'PreGet', @algoTrader.updateFragment);
            
        end
        
        
        set(algoTrader, varargin)
        
        values = wideGet(algoTrader, varargin)
        
        wideSet(algoTrader, varargin)
        
        fitness = fitness(algoTrader, methodWithArguments)
        
        optimize(algoTrader, varargin)
        
        optimizeFragments(algoTrader, varargin)
        
        newObj = clone(this)
        
        simulate(algoTrader)
        
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
