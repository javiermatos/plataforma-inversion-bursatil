
classdef TradingEngineOscillator < TradingEngine
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = TradingEngineOscillator(fts)
            
            te = te@TradingEngine(fts);
            
        end
        
        
        %% Methods that can be reimplemented in subclasses
        
        fig = plot(te, startRange, endRange, fun)
        
        output = plotOscillator(te, startRange, endRange, axesHandle)
        
        plotOscillatorCustomizer(te, startIndex, endIndex, axesHandle, varargin)
        
        
    end
    
    
end
