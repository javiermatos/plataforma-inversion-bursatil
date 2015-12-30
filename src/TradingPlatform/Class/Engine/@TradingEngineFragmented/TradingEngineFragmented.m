
classdef TradingEngineFragmented < TradingEngine
    
    
    %% FragmentSize, Jump, MaximumSamples, BeginningIndex
    properties (GetAccess = public, SetAccess = public)
        
        FragmentSize
        
        Jump
        
        BeginningIndex
        
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
        function te = TradingEngineFragmented(fts, fragmentSize, jump, beginningIndex)
            
            te = te@TradingEngine(fts);
            
            if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
            te.FragmentSize = fragmentSize;
            
            if ~exist('jump','var'); jump = Default.Jump; end
            te.Jump = jump;
            
            if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
            te.BeginningIndex = beginningIndex;
            
        end
        
        
        %% Methods
        
        [startIndex, endIndex] = fragmentTrainingRange(te, fragmentNumber)
        
        [startIndex, endIndex] = fragmentTestRange(te, fragmentNumber)
        
        fragmentIndex = firstTailFragment(te)
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        signalFragment = computeSignalFragment(te, startIndex, endIndex)
        
        
    end
    
    
end
