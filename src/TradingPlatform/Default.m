

classdef Default < handle
    
    properties (Constant = true)
        
        % AlgoTrader
        TrainingSet             = 0
        TestSet                 = 1
        BothSets                = 2
        AllValues               = 3
        TargetSet               = Default.TestSet
        
        LongPositions           = 0
        ShortPositions          = 1
        LongShortPositions      = 2
        AllowedPositions        = Default.LongShortPositions
        
        Split                   = 0.5 % Split between training and test sets
        TrainingSetInterval     = @(n) [1 floor(n*Default.Split)];
        TestSetInterval         = @(n) [floor(n*Default.Split)+1 n];
        
        InitialFunds            = 10000
        InvestmentLimit         = 10000
        TradingCost             = [ 3000	3   0; ...      % Operation cost is 3 up to 3000€
                                    6000	5   0; ...      % Operation cost is 5 up to 6000€
                                    90000   0   0.15; ...   % Operation cost is 0.15% up to 90000€
                                    Inf     0   0.10];      % Operation cost is 0.10% starting from 90000€
        
        
        % Indicator strategies
        MovingAverage           = createStruct( ...
                                    'Mode', 'e', ... % 's','l','e','m','t'
                                    'Samples', 15 ...
                                    );
        
        MovingAverageDisplaced  = createStruct(Default.MovingAverage, ...
                                    'Displacement', 3 ...
                                    );
        
        MovingAverageThreshold  = createStruct(Default.MovingAverage, ...
                                    'RiseThreshold', 1.025, ...
                                    'FallThreshold', 0.975 ...
                                    );
        
        MovingAveragesCrossing  = createStruct( ...
                                    'Mode', 'e', ... % 's','l','e','m','t'
                                    'Lead', 5, ...
                                    'Lag', 10 ...
                                    );
        
        MovingAveragesCrossingThreshold = createStruct(Default.MovingAveragesCrossing, ...
                                    'RiseThreshold', 1.025, ...
                                    'FallThreshold', 0.975 ...
                                    );
        
        BollingerBands          = createStruct( ...
                                    'Samples', 15, ...
                                    'K', 1.5 ...
                                    );
        
        
        % Oscillator strategies
        MovingAverageConvergenceDivergence = createStruct( ...
                                    'Mode', 'e', ...
                                    'Lead', 5, ...
                                    'Lag', 10, ...
                                    'Samples', 10 ...
                                    );
        
        RelativeStrengthIndex   = createStruct( ...
                                    'Samples', 14, ...
                                    'RiseThreshold', 80, ...
                                    'FallThreshold', 20 ...
                                    );
        
        RelativeStrengthIndexCrossing = createStruct(Default.RelativeStrengthIndex, ...
                                    'CMode', 'e', ...
                                    'CSamples', 10 ...
                                    );
        
        Stochastic              = createStruct( ...
                                    'Samples', 10, ...
                                    'RiseThreshold', 80, ...
                                    'FallThreshold', 20, ...
                                    'Mode', 'e', ...
                                    'KSamples', 1, ...
                                    'DSamples', 3 ...
                                    );
        
        StochasticCrossing      = createStruct(Default.Stochastic ...
                                    );
        
        StochasticStateMachine  = createStruct(Default.Stochastic ...
                                    );
        
        Momentum                = createStruct( ...
                                    'Delay', 10 ...
                                    );
        
        MomentumCrossing        = createStruct(Default.Momentum, ...
                                    'Mode', 'e', ...
                                    'Samples', 3 ...
                                    );
        
        AverageDirectionalIndex = createStruct( ...
                                    'Mode', 'e', ...
                                    'Samples', 3 ...
                                    );
        
        
        % Linear models
        % Autoregessive model
        AR                      = createStruct( ...
                                    'Order', 3, ...
                                    'Method', 'yw', ... % 'burg', 'fb', 'gl', 'ls', 'yw'
                                    'K', 10 ...
                                    );
        
        ARMA                    = createStruct( ...
                                    'Na', 3, ... % number of poles
                                    'Nc', 3, ... % number of C coefficients
                                    'Method', 'Auto', ... % 'Auto', 'gn', 'gna', 'lm', 'lsqnonlin'
                                    'K', 10 ...
                                    );
        
        
        % Fake optimum
        FakeOptimum             = createStruct( ...
                                    'Foresee', 1 ...
                                    );
        
        
        % Random
        Random                  = createStruct( ...
                                    'MinimumPeriodLength', 1, ...
                                    'MaximumPeriodLength', 20 ...
                                    );
        
        
        % LastN Strategies
        LastN                   = createStruct( ...
                                    'Samples', 5 ...
                                    );
        
        LastNRatio              = createStruct( ...
                                    'Samples', 5, ...
                                    'RiseFallRatio', 1.2, ...
                                    'FallRiseRatio', 1.2 ...
                                    );
        
        LastNWeighted           = createStruct( ...
                                    'Weight', (1:5)/5 ...
                                    );
        
        LastNTrends             = createStruct(Default.LastN ...
                                    );
        
        LastNTrendsWeighted     = createStruct( ...
                                    'Weight', (1:5)/5 ...
                                    );
        
        
        % Fragmented Strategies
        Fragmented              = createStruct( ...
                                    'TrainingSetSize', 25, ...
                                    'TestSetSize', 10 ...
                                    );
        
        
        % Joint strategies
        Voting                  = createStruct( ...
                                    'Ratio', 0.5 ...
                                    );
        
        
        % Common plot
        BackgroundColor         = [0.9 0.9 0.9]
        GridColor               = [0.2 0.2 0.2]
        Box                     = 'on'
        XGrid                   = 'on'
        YGrid                   = 'on'
        DateFormat              = 'yyyy.mm.dd'
        ShowLegend              = true
        
        
        % DataSerie Figures
        OpenLineStyle           = '-'
        OpenLineColor           = 'b'
        HighLineStyle           = '--'
        HighLineColor           = 'r'
        LowLineStyle            = '--'
        LowLineColor            = 'g'
        CloseLineStyle          = '-'
        CloseLineColor          = 'k'
        DiffSerieLineStyle      = '-'
        DiffSerieLineColor      = 'k'
        PriceLineWidth          = 1
        
        VolumeType              = 0
        % Type bar (VolumeType = 0)
        VolumeFaceColor         = 'r'
        VolumeEdgeColor         = 'r'
        VolumeBarWidth          = 1
        % Type line (VolumeType = 1)
        VolumeLineStyle         = '-'
        VolumeLineColor         = 'r'
        VolumeLineWidth         = 1
        
        
        % AlgoTrader Figures
        LongPositionLineStyle   = '-'
        LongPositionLineColor   = 'g'
        ShortPositionLineStyle  = '-'
        ShortPositionLineColor  = 'r'
        NoPositionLineStyle     = '-'
        NoPositionLineColor     = 'k'
        PositionLineWidth       = 1
        
    end
    
end

function createdStruct = createStruct(varargin)

if ~isstruct(varargin{1})
    % Create new struct wrapping cells to use struct function
    
    for i = 2:2:length(varargin)
        if iscell(varargin(i))
            varargin(i) = {varargin(i)};
        end
    end

    createdStruct = struct(varargin{:});
    
else
    % Create new struct from a source struct and additional fields
    
    createdStruct = varargin{1};
    varargin = varargin(2:end);
    
    for i = 1:length(varargin)/2
        subsasgn(createdStruct, struct('type','.','subs',varargin{i*2-1}), varargin{i*2});
    end
    
end

end
