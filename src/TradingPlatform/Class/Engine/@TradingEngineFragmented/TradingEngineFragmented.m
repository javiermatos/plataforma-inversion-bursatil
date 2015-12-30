
classdef TradingEngineFragmented < TradingEngine
    
    
    %% FragmentSize, Jump, MaximumSamples, BeginningIndex, SmothnessFunction, SmoothnessSamples
    properties (GetAccess = public, SetAccess = public)
        
        FragmentSize
        
        Jump
        
        BeginningIndex
        
        SmoothnessFunction
        
        SmoothnessSamples
        
    end
    
    methods
        
        % FragmentSize SET
        function te = set.FragmentSize(te, FragmentSize)
            te.FragmentSize = FragmentSize;
        end
        
        % Jump SET
        function te = set.Jump(te, Jump)
            te.Jump = Jump;
        end
        
        % BeginningIndex SET
        function te = set.BeginningIndex(te, BeginningIndex)
            te.BeginningIndex = BeginningIndex;
        end
        
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
    
    
    %% Dependent properties
    properties (Dependent = true)
        
        Fragments
        
    end
    
    methods
        
        % Fragments GET
        function Fragments = get.Fragments(te)
            Fragments = ceil((te.FinancialTimeSerie.Length-te.BeginningIndex+1)/te.Jump);
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = TradingEngineFragmented(fts, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)
            
            te = te@TradingEngine(fts);
            
            if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
            te.FragmentSize = fragmentSize;
            
            if ~exist('jump','var'); jump = Default.Jump; end
            te.Jump = jump;
            
            if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
            te.BeginningIndex = beginningIndex;
            
            if ~exist('smoothnessFunction','var'); smoothnessFunction = Default.SmoothnessFunction; end
            te.SmoothnessFunction = smoothnessFunction;
            
            if ~exist('smoothnessSamples','var'); smoothnessSamples = Default.SmoothnessSamples; end
            te.SmoothnessSamples = smoothnessSamples;
            
            % Here training set will be input data since the first value
            % until the last value in the first fragment.
            [~, index] = te.fragmentRange(1);
            te.Partition = index/te.FinancialTimeSerie.Length;
            
        end
        
        
        %% Methods
        
        [startIndex, endIndex] = fragmentRange(te, fragmentNumber)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        signalFragment = computeSignalFragment(te, fragmentNumber, startIndex, endIndex)
        
        
        %% Methods that can be reimplemented in subclasses
        
        fitness = computeFitness(te, set)
        
        
    end
    
    
end
