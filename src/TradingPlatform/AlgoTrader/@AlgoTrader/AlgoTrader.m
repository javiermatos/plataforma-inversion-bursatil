
classdef AlgoTrader < handle
    
    
    %% DataSerie
    properties (GetAccess = public, SetAccess = private)
        
        DataSerie
        
    end
    
    
    %% TrainingSet
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        TrainingSet
        
    end
    
    methods
        
        function set.TrainingSet(algoTrader, TrainingSet)
            
            if length(TrainingSet) ~= 2
                error('Error: TrainingSet must be an interval [a b]');
            elseif (TrainingSet(1) > TrainingSet(2))
                error('Error: TrainingSet(1) > TrainingSet(2)');
            elseif TrainingSet(1) < 1 || TrainingSet(2) > algoTrader.DataSerie.Length
                error(['Error: values out of range [1 ' num2str(algoTrader.DataSerie.Length) ']']);
            else
                algoTrader.TrainingSet = TrainingSet;
            end
            
        end
        
    end
    
    
    %% TestSet
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        TestSet
        
    end
    
        methods
        
        function set.TestSet(algoTrader, TestSet)
            
            if length(TestSet) ~= 2
                error('Error: TestSet must be an interval [a b].');
            elseif (TestSet(1) > TestSet(2))
                error('Error: TestSet(1) > TestSet(2).');
            elseif TestSet(1) < 1 || TestSet(2) > algoTrader.DataSerie.Length
                error(['Error: values out of range [1 ' num2str(algoTrader.DataSerie.Length) ']']);
            else
                algoTrader.TestSet = TestSet;
            end
            
        end
        
    end
    
    
    %% Signal
    properties (GetAccess = public, SetAccess = protected, GetObservable)
        
        Signal
        
    end
    
    methods
        
        function Signal = get.Signal(algoTrader)
            
            % InvertSignal
            if ~algoTrader.InvertSignal
                Signal = algoTrader.Signal;
            else
                Signal = algoTrader.Signal*-1;
            end
            
            % AllowTypePositions
            if algoTrader.AllowedPositions == 0
                % Only long positions
                Signal(Signal==-1) = 0;
            elseif algoTrader.AllowedPositions == 1
                % Only short positions
                Signal(Signal==1) = 0;
            end
            
        end
        
    end
    
    
    %% InvertSignal
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        InvertSignal;
        
    end
    
    methods
        
        % InvertSignal SET
        function set.InvertSignal(algoTrader, InvertSignal)
            
            if InvertSignal == 0 || InvertSignal == 1
                algoTrader.InvertSignal = InvertSignal;
            else
                error('Error: only values 0 (False) and 1 (True) are allowed.');
            end
            
        end
        
    end
    
    
    %% AllowshortPosition
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        AllowedPositions
        
    end
    
    methods
        
        % AllowerPositions SET
        function set.AllowedPositions(algoTrader, AllowedPositions)
            
            if AllowedPositions >= 0 && AllowedPositions <= 2
                algoTrader.AllowedPositions = AllowedPositions;
            else
                error('Error: only values 0 (Long positions), 1 (Short positions) and 2 (Long/Short positions) are allowed.');
            end
            
        end
        
    end
    
    
    properties (Dependent = true)
        
        ProfitLossTrainingSet
        
        ProfitLossTestSet
        
    end
    
    methods
        
        % ProfitLossTrainingSet
        function ProfitLossTrainingSet = get.ProfitLossTrainingSet(algoTrader)
            ProfitLossTrainingSet = algoTrader.profitLoss(Settings.TrainingSet);
        end
        
        % ProfitLossTestSet
        function ProfitLossTestSet = get.ProfitLossTestSet(algoTrader)
            ProfitLossTestSet = algoTrader.profitLoss(Settings.TestSet);
        end
        
    end
    
    
    %% InitialFunds
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        InitialFunds
        
    end
    
    
    %% CurrentFunds
    properties (Dependent = true)
        
        CurrentFunds
        
    end
    
    methods
        
        % CurrentFunds GET
        function CurrentFunds = get.CurrentFunds(algoTrader)
            CurrentFunds = algoTrader.InitialFunds*algoTrader.profitLoss(Settings.TestSet);
        end
        
    end
    
    
    %% InvestmentLimit, TradingCost
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        InvestmentLimit
        
        TradingCost
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function algoTrader = AlgoTrader(dataSerie)
            
            algoTrader.DataSerie = dataSerie;
            
            algoTrader.TrainingSet = Settings.TrainingSetInterval(dataSerie.Length);
            algoTrader.TestSet = Settings.TestSetInterval(dataSerie.Length);
            
            algoTrader.InvertSignal = false;
            algoTrader.AllowedPositions = Settings.AllowedPositions;
            
            % In the future these properties will be in a manager object
            % that will use algoTrader in order to make investments
            algoTrader.InitialFunds = Settings.InitialFunds;
            algoTrader.InvestmentLimit = Settings.InvestmentLimit;
            algoTrader.TradingCost = Settings.TradingCost;
            
            % Events
            addlistener(algoTrader, 'Signal', 'PreGet', @algoTrader.updateSignal);
            
        end
        
        
        profitLoss = profitLoss(algoTrader, setSelector, rangeInit, rangeEnd)
        
        [profitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
            = profitLossSerie(algoTrader, setSelector, rangeInit, rangeEnd)
        
        [positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
            = positionSerie(algoTrader, setSelector, rangeInit, rangeEnd)
        
        [diffProfitLossSerie, positionSerie, priceSerie, dateTimeSerie, longPosition, shortPosition, noPosition] ...
            = diffProfitLossSerie(algoTrader, setSelector, rangeInit, rangeEnd)
        
        [longPosition, shortPosition, noPosition, initIndex, endIndex] ...
            = signal2positions(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotWrapper(algoTrader, customizer, axesHandle, setSelector, rangeInit, rangeEnd, varargin)
        
        fig = plot(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotSeriePosition(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotPosition(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotProfitLoss(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotDiffProfitLoss(algoTrader, setSelector, rangeInit, rangeEnd)
        
        fig = plotSignal(algoTrader, setSelector, rangeInit, rangeEnd)
        
        printPositionsLog(algoTrader, setSelector, rangeInit, rangeEnd)
        
        performance = fitness(algoTrader, fitnessMethodWithArguments)
        
        [minFitness, maxFitness, meanFitness, stdFitness] ...
            = fitnessStatistics(algoTrader, varargin)
        
        varargout = optimize(algoTrader, varargin)
        
        fig = plotSearchSpace(algoTrader, varargin)
        
        fig = plotSearchSpace123(algoTrader, varargin)
        
        [positionType, openIndex, closeIndex, openDate, closeDate, openPrice, closePrice, profitLoss] ...
            = positionsLog(algoTrader, setSelector, rangeInit, rangeEnd)
        
        newObj = clone(this)
        
    end
    
    
    methods (Access = protected)
        
        %fig = plotWrapper(algoTrader, customizer, axesHandle, setSelector, rangeInit, rangeEnd, varargin)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
        drawPosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
        drawProfitLoss(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
        drawDiffProfitLoss(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
        drawSignal(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
        resetSignal(algoTrader, src, event)
        
        updateSignal(algoTrader, src, event)
        
        performance = fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray)
        
    end
    
    
    methods (Access = public, Abstract)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
