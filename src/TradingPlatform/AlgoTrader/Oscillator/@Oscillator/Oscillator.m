
classdef Oscillator < AlgoTrader
    
    
    methods (Access = public)
        
        function algoTrader = Oscillator(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
        end
        
        
        fig = plot(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotOscillator(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotSeriePositionOscillator(algoTrader, setSelector, rangeInit, rangeEnd)
        
        
    end
    
    
    methods (Access = protected, Abstract)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
    methods (Access = public, Abstract)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
