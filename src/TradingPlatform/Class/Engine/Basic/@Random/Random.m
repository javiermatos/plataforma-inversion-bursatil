
classdef Random < TradingEngine
    
    
    %% SignalValue
    properties (Access = private)
        
        SignalValue
        
    end
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = Random(fts)
            
            te = te@TradingEngine(fts);
            
            te.SignalValue = int8(randi([-1 1], 1, te.FinancialTimeSerie.Length));
            
        end
        
        
        %% Methods that must be reimplemented in subclasses
        function signal = computeSignal(te)
            
            signal = te.SignalValue;
            
        end
        
        
    end
    
    
end
