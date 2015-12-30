
classdef Default < handle
    
    properties (Constant = true)
        
        % TradingEngine basic properties
        Partition               = 0.8           % PartitionDate has preference over Partition
        PartitionDate           = '2010-01-05'  % PartitionDate has preference over Partition
        Measurement             = 'Relative'
        Investment              = 10000
        TradeCost               = 2.5
        ConversionRatio         = 1             % Tick2Money
        
        % Moving average
        Mode                    = 'simple'
        ModeDomain              = {'s','l','e','m'}
        Samples                 = 15
        SamplesDomain           = 1:50
        
        % Moving average displaced
        Displacement            = 3
        DisplacementDomain      = 1:20
        
        % Moving average crossing
        Lead                    = 5
        Lag                     = 10
        LeadLagDomain           = 1:50
        
        % Threshold
        RiseThreshold           = 0.0025
        FallThreshold           = 0.0025
        RiseThresholdDomain     = linspace(0,0.005,5)
        FallThresholdDomain     = linspace(0,0.005,5)
        RiseFallThresholdDomain = linspace(0,0.005,5)
        
        % Bollinger bands
        K                       = 1.5
        KDomain                 = linspace(1,3,5)
        
        % Stochastic
        StochasticSamples       = 10
        HighThreshold           = 0.8
        LowThreshold            = 0.2
        HighThresholdDomain     = linspace(0.6,0.9,4)
        LowThresholdDomain      = linspace(0.1,0.4,4)
        
        % Stochastic crossing
        %Mode                    = 'simple'     % Previously defined
        MovingAverageSamples    = 10
        
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
        
        
        % Plot
        BackgroundColor         = [0.9 0.9 0.9]
        GridColor               = [0.2 0.2 0.2]
        Box                     = 'off'
        XGrid                   = 'on'
        YGrid                   = 'on'
        DateFormat              = 'yyyy.mm.dd'
        
        % FinancialTimeSerie plot
        OpenLineSpec            = 'b'
        HighLineSpec            = '--r'
        LowLineSpec             = '--g'
        CloseLineSpec           = 'k'
        PriceLineWidth          = 1
        VolumeFaceColor         = 'r'
        VolumeEdgeColor         = 'k'
        VolumeBarWidth          = 1
        
        % TradingEngine plot
        LongPositionLineSpec    = 'g'
        ShortPositionLineSpec   = 'r'
        NoPositionLineSpec      = 'k'
        PositionLineWidth       = 2
        ProfitLossLineSpec      = 'b'
        ProfitLossLineWidth     = 2
        
        SignalLineSpec          = 'b'
        SignalLineWidth         = 2
        
    end
    
end
