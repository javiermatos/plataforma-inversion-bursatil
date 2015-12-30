
classdef Settings < handle
    
    properties (Constant = true)
        
        
        % AlgoTrader
        InitialIndexRatio       = 0
        SplitIndexRatio         = 0.8
        AllowShortPosition      = true
        InitialFunds            = 10000
        InvestmentLimit         = Inf
        TradingCost             = 0
        Tick2Money              = 1
        Money2Tick              = 1/Settings.Tick2Money
        
        
        % Indicator strategies
        MovingAverage           = createStruct( ...
                                    'Mode', 'e', ... % 's','l','e','m','t'
                                    'Samples', 15 ...
                                    );
        
        MovingAverageDisplaced  = createStruct(Settings.MovingAverage, ...
                                    'Displacement', 3 ...
                                    );
        
        MovingAverageThreshold  = createStruct(Settings.MovingAverage, ...
                                    'RiseThreshold', 0.025, ...
                                    'FallThreshold', 0.025 ...
                                    );
        
        MovingAveragesCrossing  = createStruct( ...
                                    'Mode', 'e', ... % 's','l','e','m','t'
                                    'Lead', 5, ...
                                    'Lag', 10 ...
                                    );
        
        MovingAveragesCrossingThreshold = createStruct(Settings.MovingAveragesCrossing, ...
                                    'RiseThreshold', 0.025, ...
                                    'FallThreshold', 0.025 ...
                                    );
        
        BollingerBands          = createStruct(Settings.MovingAverage, ...
                                    'K', 1.5 ...
                                    );
        
        
        % Oscillator strategies
        RelativeStrengthIndex   = createStruct( ...
                                    'Samples', 14, ...
                                    'HighThreshold', 80, ...
                                    'LowThreshold', 20 ...
                                    );
        
        RelativeStrengthIndexCrossing = createStruct( ...
                                    'Samples', 14, ...
                                    'Mode', 'e', ...
                                    'CrossingSamples', 10 ...
                                    );
        
        Stochastic              = createStruct( ...
                                    'Samples', 10, ...
                                    'HighThreshold', 80, ...
                                    'LowThreshold', 20 ...
                                    );
        
        StochasticCrossing      = createStruct( ...
                                    'Samples', 10, ...
                                    'Mode', 'e', ...
                                    'CrossingSamples', 10 ...
                                    );
        
        MovingAverageConvergenceDivergence = createStruct( ...
                                    'Mode', 'e', ...
                                    'Lead', 5, ...
                                    'Lag', 10, ...
                                    'SignalMode', 'e', ...
                                    'SignalSamples', 10 ...
                                    );
        
        Momentum = createStruct( ...
                                    'Delay', 10 ...
                                    );
        
        
        % Fragmented Strategies
        Fragmented              = createStruct( ...
                                    'Size', 100, ...
                                    'Jump', 50, ...
                                    'SmoothnessFunction', 'e', ...
                                    'SmoothnessSamples', 1 ...
                                    );
        
        
        % Joint strategies
        Union                   = createStruct( ...
                                    'VotesRatio', 0.5 ...
                                    );
        
        
        % LastN Strategies
        LastN                   = createStruct( ...
                                    'Samples', 5 ...
                                    );
        
        LastNWeighted           = createStruct( ...
                                    'Weight', (1:5)/5 ...
                                    );
        
        LastNIncrementDecrement = createStruct( ...
                                    'Samples', 5 ...
                                    );
                                
        LastNIncrementDecrementWeighted = createStruct( ...
                                    'Weight', (1:5)/5 ...
                                    );
        
        
        % Fragmented
        FragmentSize            = 100
        Jump                    = 25
        BeginningIndex          = 200
        SmoothnessFunction      = 'simple'
        SmoothnessSamples       = 1
        
        %ModeDomainF             = {'s','l','e','m','t'}
        ModeDomainF             = {'s','l','e','m'}
        SamplesDomainF          = 1:50
        LeadLagDomainF          = 1:50
        RiseFallThresholdDomainF= linspace(0,0.005,5)
        
        
        % Neural Network Strategies
        % Neural Network
        InputSize               = 50
        
        
        % Common plot
        BackgroundColor         = [0.9 0.9 0.9]
        GridColor               = [0.2 0.2 0.2]
        Box                     = 'off'
        XGrid                   = 'on'
        YGrid                   = 'on'
        DateFormat              = 'yyyy.mm.dd'
        
        
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
        
        PositionType            = 0 % 0 -> line; 1 -> rectangle
        
        % Type line (PositionType = 0)
        ProfitLossLineStyle     = '-'
        ProfitLossLineColor     = 'b'
        ProfitLossLineWidth     = 1
        
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
