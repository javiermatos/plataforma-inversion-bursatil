
classdef TradingEngine
    
    
    %% FinancialTimeSerie
    properties (GetAccess = public, SetAccess = private)
        
        FinancialTimeSerie      % Financial time serie
        
    end
    
    
    %% Partition, Measurement, TradeCost, ConversionRatio
    properties (GetAccess = public, SetAccess = public)
        
%         Beginning               % Start index of fts
        
        Partition               % Quantity of values to train the system
        
        Measurement             % Measurement
                                % Needed to compute ProfitLoss* and others
        
        Investment              % Investment or initial funds
        
        TradeCost               % Unitary transaction cost (price)

        
    end
    
    methods
        
%         % Beginning SET
%         function te = set.Beginning(te, Beginning)
%             if Beginning < 0 || Beginning > 1
%                 error('Beginning value must be in [0 1].');
%             end
%             te.Beginning = Beginning;
%         end
        
        % Partition SET
        function te = set.Partition(te, Partition)
            if Partition < 0 || Partition > 1
                error('Partition value must be in [0 1].');
            end
            te.Partition = Partition;
        end
        
        % Measurement SET
        function te = set.Measurement(te, Measurement)
            if ~strcmpi('relative', Measurement) && ~strcmpi('absolute', Measurement)
                error('Measurement property must be ''Absolute'' or ''Relative''.');
            end
            te.Measurement = Measurement;
        end
        
        % Investment
        function te = set.Investment(te, Investment)
            if Investment < 0
                error('Investment value must be positive.');
            end
            te.Investment = Investment;
        end
        
        % TradeCost SET
        function te = set.TradeCost(te, TradeCost)
            if TradeCost < 0
                error('TradeCost value must be positive.');
            end
            te.TradeCost = TradeCost;
        end
        
    end
    
    
    %% ConversionRatio
    properties (GetAccess = private, SetAccess = private)
        
        ConversionRatio         % Conversion ration between money and tick
                                % ConversionRatio * tick = money
                                
    end
    
    methods
        
        % ConversionRatio SET
        function te = set.ConversionRatio(te, ConversionRatio)
            if ConversionRatio < 0
                error('ConversionRatio value must be positive.');
            end
            te.ConversionRatio = ConversionRatio;
        end
        
    end
    
    
    %% Dependent properties
    properties (Dependent = true)
        
%         BeginningIndex          % First training day
%         
%         BeginningDate           % First training day
        
        PartitionIndex          % Last training day
        
        PartitionDate           % Last training day
        
        SetItems                % FinancialTimeSerie.Length
        
        TrainingSetItems        % Training set items
        
        TestSetItems            % Test set items
        
        TrainingSet             % Training set
        
        TestSet                 % Test set
        
        Signal              	% Signal produced by the engine
                                % Signal(n) = {-1, 0, 1}
        
        ProfitLoss              % Profit/Loss
        
        ProfitLossSerie         % Profit/Loss serie
        
%        ProfitLossPerPosition   % Profit/Loss per position
        
        Fitness                 % Fitness of the engine ('training' set)
        
        ExtendedFitness         % Fitness of the engine ('all' set)
        
        Tick2Money
        
        Money2Tick
        
    end
    
    methods
        
%         % BeginningIndex GET
%         function BeginningIndex = get.BeginningIndex(te)
%             BeginningIndex = round(te.FinancialTimeSerie.Length*te.Beginning);
%             if BeginningIndex == 0
%                 BeginningIndex = 1;
%             end
%         end
%         
%         % BeginningIndex SET
%         function te = set.BeginningIndex(te, BeginningIndex)
%             if BeginningIndex < 1 || BeginningIndex > te.FinancialTimeSerie.Length
%                 error(['BeginningIndex value must be in [1 ', num2str(te.FinancialTimeSerie.Length),']']);
%             end
%             te.Beginning = BeginningIndex/te.FinancialTimeSerie.Length;
%         end
%         
%         % BeginningDate GET
%         function BeginningDate = get.BeginningDate(te)
%             BeginningDate = datestr(te.FinancialTimeSerie.Date(te.BeginningIndex), 'yyyy-mm-dd');
%         end
%         
%         % BeginningDate SET
%         function te = set.BeginningDate(te, BeginningDate)
%             fts = te.FinancialTimeSerie;
%             dateNumber = datenum(BeginningDate);
%             if dateNumber < fts.Date(1) || dateNumber > fts.Date(end)
%                 error(['Date must be between ', datestr(fts.Date(1), 'yyyy-mm-dd'), ' and ', datestr(fts.Date(end), 'yyyy-mm-dd'), '.']);
%             end
%             te.Beginning = (dateNumber-fts.Date(1))/(fts.Date(end)-fts.Date(1));
%         end
        
        % PartitionIndex GET
        function PartitionIndex = get.PartitionIndex(te)
            PartitionIndex = round(te.FinancialTimeSerie.Length*te.Partition);
            if PartitionIndex == 0
                PartitionIndex = 1;
            end
        end
        
        % PartitionIndex SET
        function te = set.PartitionIndex(te, PartitionIndex)
            if PartitionIndex < 1 || PartitionIndex > te.FinancialTimeSerie.Length
                error(['PartitionIndex value must be in [1 ', num2str(te.FinancialTimeSerie.Length),']']);
            end
            te.Partition = PartitionIndex/te.FinancialTimeSerie.Length;
        end
        
        % PartitionDate GET
        function PartitionDate = get.PartitionDate(te)
            PartitionDate = datestr(te.FinancialTimeSerie.Date(te.PartitionIndex), 'yyyy-mm-dd');
        end
        
        % PartitionDate SET
        function te = set.PartitionDate(te, PartitionDate)
            fts = te.FinancialTimeSerie;
            dateNumber = datenum(PartitionDate);
            if dateNumber < fts.Date(1) || dateNumber > fts.Date(end)
                error(['Date must be between ', datestr(fts.Date(1), 'yyyy-mm-dd'), ' and ', datestr(fts.Date(end), 'yyyy-mm-dd'), '.']);
            end
            te.Partition = (dateNumber-fts.Date(1))/(fts.Date(end)-fts.Date(1));
        end
        
        % SetItems GET
        function SetItems = get.SetItems(te)
            SetItems = te.FinancialTimeSerie.Length;
        end
       
        % TrainingSetItems GET
        function TrainingSetItems = get.TrainingSetItems(te)
            TrainingSetItems = te.PartitionIndex-1;
        end
        
        % TestSetItems GET
        function TestSetItems = get.TestSetItems(te)
            TestSetItems = te.FinancialTimeSerie.Length-te.TrainingSetItems;
        end
        
        % TrainingSet GET
        function TrainingSet = get.TrainingSet(te)
            TrainingSet = te.FinancialTimeSerie.subset(1, te.TrainingSetItems);
        end
        
        % TestSet GET
        function TestSet = get.TestSet(te)
            TestSet = te.FinancialTimeSerie.subset(te.TrainingSetItems+1, te.FinancialTimeSerie.Length);
        end
        
        % Signal GET
        function Signal = get.Signal(te)
            Signal = te.computeSignal();
        end
        
        % ProfitLoss GET
        function ProfitLoss = get.ProfitLoss(te)
            ProfitLoss = te.computeProfitLoss('test');
        end
        
        % ProfitLossSerie GET
        function ProfitLossSerie = get.ProfitLossSerie(te)
            ProfitLossSerie = te.computeProfitLossSerie('test');
        end
        
%         % ProfitLossPerPosition GET
%         function ProfitLossPerPosition = get.ProfitLossPerPosition(te)
%             ProfitLossPerPosition = te.computeProfitLossPerPosition('test');
%         end
        
        % Fitness GET
        function Fitness = get.Fitness(te)
            % We don't specify any sat, this way we can change the default
            % behaviour of Fitness property by changing computeFitness
            % definition.
            Fitness = te.computeFitness();
        end
        
        % ExtendedFitness GET
        function ExtendedFitness = get.ExtendedFitness(te)
            ExtendedFitness = te.computeFitness('all');
        end
        
        % Tick2Money GET
        function Tick2Money = get.Tick2Money(te)
            Tick2Money = te.ConversionRatio;
        end
        
        % Tick2Money SET
        function te = set.Tick2Money(te, tick2money)
            te.ConversionRatio = tick2money;
        end
        
        % Money2Tick GET
        function Money2Tick = get.Money2Tick(te)
            Money2Tick = 1/te.ConversionRatio;
        end
        
        % Money2Tick SET
        function te = set.Money2Tick(te, money2tick)
            te.ConversionRatio = 1/money2tick;
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = TradingEngine(fts)
            
            te.FinancialTimeSerie = fts;
            
            %te.Partition = Default.Partition;
            
            % If Default.PartitionDate does not exist or if it exist but is
            % outside the range we don't assign that value.
            if any(strcmpi(fieldnames(Default),'PartitionDate')) && ...
                    datenum(Default.PartitionDate) >= fts.Date(1) && ...
                    datenum(Default.PartitionDate) <= fts.Date(end)
                
                te.PartitionDate = Default.PartitionDate;
            else
                te.Partition = Default.Partition;
            end
            
            te.Measurement = Default.Measurement;
            
            te.Investment = Default.Investment;
            
            te.TradeCost = Default.TradeCost;
            
            te.ConversionRatio = Default.ConversionRatio;
            
        end
        
        
        %% Methods
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
        %% Methods that can be reimplemented in subclasses
        
        fitness = computeFitness(te, set)
        
        fig = plot(te, startRange, endRange, fun)
        
        fig = plotl(te, startRange, endRange)
        
        output = plotWrapper(te, startRange, endRange, axesHandle, customizer, varargin)
        
        output = plotSerie(te, startRange, endRange, fun, axesHandle)
        
        plotSerieCustomizer(te, startIndex, endIndex, axesHandle, fun, description)
        
        output = plotProfitLoss(te, startRange, endRange, axesHandle)
        
        plotProfitLossCustomizer(te, startIndex, endIndex, axesHandle, varargin)
        
        output = plotSignal(te, startRange, endRange, axesHandle)
        
        plotSignalCustomizer(te, startIndex, endIndex, axesHandle, varargin)
        
        
        %% Methods that must not be reimplemented in subclases
        
        profitLoss = computeProfitLoss(te, set)
        
        profitLossSerie = computeProfitLossSerie(te, set)
        
%        profitLossPerPosition = computeProfitLossPerPosition(te, set)
        
        % Optimization methods
        fitness = exhaustiveFitness(te, varargin)
        
        [optimum, fitness] = exhaustiveProperties(te, varargin)
        
        engine = exhaustiveOptimizer(te, varargin)
        
        
    end
    
    
    %% Private class methods
    methods (Access = private)
        
        [longPosition, shortPosition, noPosition] = signal2positions(te, type, startRange, endRange)
        
        [longPosition, shortPosition, noPosition, serie] = computePositionsSerie(te, set)
        
    end
    
    
end
