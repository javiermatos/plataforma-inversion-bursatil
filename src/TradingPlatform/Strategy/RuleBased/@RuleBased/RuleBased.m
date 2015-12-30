
classdef RuleBased < AlgoTrader
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Command
        
        BuyRule
        
        SellRule
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = RuleBased(dataSerie, command, buyRule, sellRule)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            algoTrader.Command = command;
            algoTrader.BuyRule = buyRule;
            algoTrader.SellRule = sellRule;
            
            % Events
            addlistener(algoTrader, 'Command', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'BuyRule', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'SellRule', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        fig = plotIndicator(algoTrader, rangeInit, rangeEnd, applySplit, varargin)
        
        fig = plotOscillator(algoTrader, rangeInit, rangeEnd, varargin)
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawIndicator(algoTrader, axesHandle, initIndex, endIndex, applySplit, varargin)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
        drawOscillator(algoTrader, axesHandle, initIndex, endIndex, varargin)
        
    end
    
    
end
