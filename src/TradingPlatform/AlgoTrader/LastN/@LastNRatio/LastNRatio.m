
classdef LastNRatio < AlgoTrader
    
    
    %% Samples, RiseFallRatio, FallRiseRatio
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Samples
        
        RiseFallRatio
        
        FallRiseRatio
        
    end
    
    methods
        
        % RiseFallRatio SET
        function set.RiseFallRatio(algoTrader, RiseFallRatio)
            if RiseFallRatio < 1
                error('Error: RiseFallRatio must be grater than 1');
            else
                algoTrader.RiseFallRatio = RiseFallRatio;
            end
        end
        
        % FallRiseRatio SET
        function set.FallRiseRatio(algoTrader, FallRiseRatio)
            if FallRiseRatio < 1
                error('Error: FallRiseRatio must be grater than 1');
            else
                algoTrader.FallRiseRatio = FallRiseRatio;
            end
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = LastNRatio(dataSerie, samples, riseFallRatio, fallRiseRatio)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('samples','var'); samples = Settings.LastNRatio.Samples; end
            if ~exist('riseFallRatio','var'); riseFallRatio = Settings.LastNRatio.RiseFallRatio; end
            if ~exist('fallRiseRatio','var'); fallRiseRatio = Settings.LastNRatio.FallRiseRatio; end
            
            algoTrader.Samples = samples;
            algoTrader.RiseFallRatio = riseFallRatio;
            algoTrader.FallRiseRatio = fallRiseRatio;
            
            % Events
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'RiseFallRatio', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'FallRiseRatio', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [risePrice, fallPrice, riseFallRatio, fallRiseRatio] ...
            = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
