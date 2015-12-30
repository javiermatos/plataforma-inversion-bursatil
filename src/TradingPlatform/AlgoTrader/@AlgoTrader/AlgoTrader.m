
classdef AlgoTrader < handle
    
    
    %% DataSerie
    properties (GetAccess = public, SetAccess = private)
        
        DataSerie
        
    end
    
    
    %% Signal
    properties (GetAccess = public, SetAccess = protected, GetObservable)
        
        Signal
        
    end
    
    methods
        
        function Signal = get.Signal(algoTrader)
            if ~algoTrader.InvertSignal
                Signal = algoTrader.Signal;
            else
                Signal = algoTrader.Signal*-1;
            end
        end
        
    end
    
    
    %% InvertSignal
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        InvertSignal = false;
        
    end
    
    
    %% InitialIndexRatio
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        InitialIndexRatio
        
    end
    
    methods
        
        % InitialIndexRatio SET
        function set.InitialIndexRatio(algoTrader, initialIndexRatio)
            if initialIndexRatio < 0 || initialIndexRatio > 1
                error('InitialIndexRatio must be between 0 and 1.');
            else
                algoTrader.InitialIndexRatio = initialIndexRatio;
            end
        end
        
    end
    
    
    %% InitialIndex
    properties (Dependent = true)
        
        InitialIndex
        
    end
    
    methods
        
        % InitialIndex GET
        function initialIndex = get.InitialIndex(algoTrader)
            initialIndex = max(1, ceil(algoTrader.InitialIndexRatio*algoTrader.DataSerie.Length));
        end
        
        % InitialIndex SET
        function set.InitialIndex(algoTrader, initialIndex)
            if initialIndex < 1 || initialIndex > algoTrader.DataSerie.Length
                error(['InitialIndex must be between 1 and ' num2str(algoTrader.DataSerie.Length) '.']);
            else
                algoTrader.InitialIndexRatio = initialIndex/algoTrader.DataSerie.Length;
            end
        end
        
    end
    
    
    %% SplitIndexRatio
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        SplitIndexRatio
        
    end
    
    methods
        
        % SplitIndexRatio SET
        function set.SplitIndexRatio(algoTrader, splitIndexRatio)
            if splitIndexRatio < 0 || splitIndexRatio > 1
                error('SplitIndexRatio must be between 0 and 1.');
            else
                algoTrader.SplitIndexRatio = splitIndexRatio;
            end
        end
        
    end
    
    
    %% SplitIndex
    properties (Dependent = true)
        
        SplitIndex
        
    end
    
    methods
        
        % SplitIndex GET
        function SplitIndex = get.SplitIndex(algoTrader)
            SplitIndex = max(1, ceil(algoTrader.SplitIndexRatio*algoTrader.DataSerie.Length));
        end
        
        % SplitIndex SET
        function set.SplitIndex(algoTrader, splitIndex)
            if splitIndex < 1 || splitIndex > algoTrader.DataSerie.Length
                error(['SplitIndex must be between 1 and ' num2str(algoTrader.DataSerie.Length) '.']);
            else
                algoTrader.SplitIndexRatio = splitIndex/algoTrader.DataSerie.Length;
            end
        end
        
    end
    
    
    %% InitTrainingSet, EndTrainingSet, TrainingSetSize, InitTestSet, EndTestSet, TestSetSize
    properties (Dependent = true)
        
        % Padding Set
        InitPaddingSet
        
        EndPaddingSet
        
        PaddingSetSize
        
        % Training Set
        InitTrainingSet
        
        EndTrainingSet
        
        TrainingSetSize
        
        % Test Set
        InitTestSet
        
        EndTestSet
        
        TestSetSize
        
    end
    
    methods
        
        % InitPaddingSet GET
        function InitPaddingSet = get.InitPaddingSet(algoTrader)
            if algoTrader.InitialIndex == 1
                InitPaddingSet = [];
            else
                InitPaddingSet = datestr(algoTrader.DataSerie.DateTime(1),'yyyy-mm-dd');
            end
        end
        
        % EndPaddingSet GET
        function EndPaddingSet = get.EndPaddingSet(algoTrader)
            if algoTrader.InitialIndex == 1
                EndPaddingSet = [];
            else
                EndPaddingSet = datestr(algoTrader.DataSerie.DateTime(algoTrader.InitialIndex-1),'yyyy-mm-dd');
            end
        end
        
        % PaddingSetSize GET
        function PaddingSetSize = get.PaddingSetSize(algoTrader)
            PaddingSetSize = algoTrader.InitialIndex-1;
        end
        
        % InitTrainingSet GET
        function InitTrainingSet = get.InitTrainingSet(algoTrader)
            InitTrainingSet = datestr(algoTrader.DataSerie.DateTime(algoTrader.InitialIndex),'yyyy-mm-dd');
        end
        
        % InitTrainingSet SET
        function set.InitTrainingSet(algoTrader, initTrainingSet)
            algoTrader.InitialIndex = find(datenum(initTrainingSet) <= algoTrader.DataSerie.DateTime, 1, 'first');
        end
        
        % EndTrainingSet GET
        function EndTrainingSet = get.EndTrainingSet(algoTrader)
            EndTrainingSet = datestr(algoTrader.DataSerie.DateTime(algoTrader.SplitIndex),'yyyy-mm-dd');
        end
        
        % EndTrainingSet SET
        function set.EndTrainingSet(algoTrader, endTrainingSet)
            algoTrader.SplitIndex = find(datenum(endTrainingSet) >= algoTrader.DataSerie.DateTime, 1, 'last');
        end
        
        % TrainingSetSize GET
        function TrainingSetSize = get.TrainingSetSize(algoTrader)
            TrainingSetSize = algoTrader.SplitIndex-algoTrader.InitialIndex+1;
        end
        
        % InitTestSet GET
        function InitTestSet = get.InitTestSet(algoTrader)
            if algoTrader.SplitIndex >= algoTrader.DataSerie.Length
                InitTestSet = [];
            else
                InitTestSet = datestr(algoTrader.DataSerie.DateTime(algoTrader.SplitIndex+1),'yyyy-mm-dd');
            end
        end
        
        % EndTestSet GET
        function EndTestSet = get.EndTestSet(algoTrader)
            if algoTrader.SplitIndex >= algoTrader.DataSerie.Length
                EndTestSet = [];
            else
                EndTestSet = datestr(algoTrader.DataSerie.DateTime(length(algoTrader.DataSerie.DateTime)),'yyyy-mm-dd');
            end
        end
        
        % TestSetSize GET
        function TestSetSize = get.TestSetSize(algoTrader)
            TestSetSize = algoTrader.DataSerie.Length - algoTrader.SplitIndex;
        end
        
    end
    
    
    %% AllowshortPosition
    properties (GetAccess = public, SetAccess = public)
        
        AllowShortPosition
        
    end
    
    
    %% InitialFunds
    properties (GetAccess = public, SetAccess = public)
        
        InitialFunds
        
    end
    
    
    %% CurrentFunds
    properties (Dependent = true)
        
        CurrentFunds
        
    end
    
    methods
        
        % CurrentFunds GET
        function CurrentFunds = get.CurrentFunds(algoTrader)
            CurrentFunds = algoTrader.InitialFunds*algoTrader.profitLoss([],[],true);
        end
        
    end
    
    
    %% InvestmentLimit, TradingCost, Tick2Money
    properties (GetAccess = public, SetAccess = public)
        
        InvestmentLimit
        
        TradingCost
        
        Tick2Money
        
    end
    
    
    %% Money2Tick
    properties (Dependent = true)
        
        Money2Tick
        
    end
    
    methods
        
        % Money2Tick GET
        function Money2Tick = get.Money2Tick(algoTrader)
            Money2Tick = 1/algoTrader.Tick2Money;
        end
        
        % Money2Tick SET
        %function algoTrader = set.Money2Tick(algoTrader, Money2Tick)
        function set.Money2Tick(algoTrader, Money2Tick)
            algoTrader.Tick2Money = 1/Money2Tick;
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function algoTrader = AlgoTrader(dataSerie)
            
            algoTrader.DataSerie = dataSerie;
            
            algoTrader.InitialIndexRatio = Settings.InitialIndexRatio;
            algoTrader.SplitIndexRatio = Settings.SplitIndexRatio;
            
            algoTrader.AllowShortPosition = Settings.AllowShortPosition;
            
            % In the future these properties will be in a manager object
            % that will use algoTrader in order to make investments
            algoTrader.InitialFunds = Settings.InitialFunds;
            algoTrader.InvestmentLimit = Settings.InvestmentLimit;
            algoTrader.TradingCost = Settings.TradingCost;
            algoTrader.Tick2Money = Settings.Tick2Money;
            
            % Events
            addlistener(algoTrader, 'InvertSignal', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Signal', 'PreGet', @algoTrader.updateSignal);
            
        end
        
        
        profitLoss = profitLoss(algoTrader, rangeInit, rangeEnd, applySplit)
        
        profitLoss = profitLossFromSet(algoTrader, set)
        
        [profitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
            = profitLossSerie(algoTrader, rangeInit, rangeEnd, applySplit)
        
        profitLossSerie = profitLossSerieFromSet(algoTrader, set)
        
        [positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
            = positionSerie(algoTrader, rangeInit, rangeEnd, applySplit)
        
        positionSerie = positionSerieFromSet(algoTrader, set)
        
        [diffProfitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
            = diffProfitLossSerie(algoTrader, rangeInit, rangeEnd, applySplit)
        
        [longPosition, shortPosition, noPosition, initIndex, endIndex] ...
            = signal2positions(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fig = plot(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fig = plotSeriePosition(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fig = plotPosition(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fig = plotProfitLoss(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fig = plotDiffProfitLoss(algoTrader, rangeInit, rangeEnd, applySplit)
        
        fitness = fitness(algoTrader, methodWithArguments)
        
        optimize(algoTrader, varargin)
        
        fig = plotSearchSpace(algoTrader, varargin)
        
        newObj = clone(this)
        
    end
    
    
    methods (Access = protected)
        
        fig = plotWrapper(dataSerie, customizer, axesHandle, rangeInit, rangeEnd, varargin)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
        drawPosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
        drawProfitLoss(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
        drawDiffProfitLoss(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
        resetSignal(algoTrader, src, event)
        
        updateSignal(algoTrader, src, event)
        
        fitnessValue = fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray)
        
    end
    
    
    methods (Access = public, Abstract)
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
