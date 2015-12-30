
classdef TradingEngineFragmentedSmooth < TradingEngineFragmented
    
    
    %% SmothnessFunction, SmoothnessSamples
    properties (GetAccess = public, SetAccess = public)
        
        SmoothnessFunction
        
        SmoothnessSamples
        
    end
    
    methods
        
        % SmoothnessType SET
        function te = set.SmoothnessFunction(te, SmoothnessFunction)
            
            if ischar(SmoothnessFunction)
                
                switch lower(SmoothnessFunction)
                    
                    case {'e', 'exponential'}
                        f = @(i) exp(1:i);
                        
                    case {'log', 'logarithmic'}
                        f = @(i) log(2:i+1);
                        
                    case {'l', 'linear'}
                        f = @(i) (1:i)/i;
                        
                    case {'s', 'simple'}
                        f = @(i) ones(1,i);
                        
                    otherwise
                        error('Not valid function name.');
                end
                
                te.SmoothnessFunction = f;
                
            else
                
                te.SmoothnessFunction = SmoothnessFunction;
                
            end
            
        end
        
        % SmoothnessSamples SET
        function te = set.SmoothnessSamples(te, SmoothnessSamples)
            te.SmoothnessSamples = SmoothnessSamples;
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = TradingEngineFragmentedSmooth(fts, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
            
            if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
            if ~exist('jump','var'); jump = Default.Jump; end
            if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
            
            te = te@TradingEngineFragmented(fts, fragmentSize, jump, beginningIndex);
            
            if ~exist('smoothnessFunction','var'); smoothnessFunction = Default.SmoothnessFunction; end
            te.SmoothnessFunction = smoothnessFunction;
            
            if ~exist('smoothnessSamples','var'); smoothnessSamples = Default.SmoothnessSamples; end
            te.SmoothnessSamples = smoothnessSamples;
            
        end
        
                
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        signalFragment = computeSignalFragment(tef, startIndex, endIndex, fragmentNumber)
        
        
    end
    
    
end
