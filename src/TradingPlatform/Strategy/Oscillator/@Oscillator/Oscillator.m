
classdef Oscillator < AlgoTrader
    
    
    methods (Access = public)
        
        function algoTrader = Oscillator(dataSerie)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
        end
        
        
        fig = plot(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fig = plotOscillator(algoTrader, rangeInit, rangeEnd, applySplit)
        
        
    end
    
    
    methods (Access = protected, Abstract)
        
        drawOscillator(algoTrader, axesHandle, initIndex)
        
    end
    
    
    methods (Access = public, Abstract)
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
