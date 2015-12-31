
classdef Random < AlgoTrader
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        MinimumPeriodLength
        
        MaximumPeriodLength
        
    end
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable)
        
        % This Dummy property is used to reset the signal generated by
        % simulation method. This way the plotSearchSpace can show a visual
        % representation of random machines.
        Dummy
        
    end
    
    methods
        
        % Dummy SET
        function set.Dummy(algoTrader, Dummy)
            % nothing to do here
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = Random(dataSerie, minimumPeriodLength, maximumPeriodLength)
            
            algoTrader = algoTrader@AlgoTrader(dataSerie);
            
            if ~exist('minimumPeriodLength','var'); minimumPeriodLength = Settings.Random.MinimumPeriodLength; end
            if ~exist('maximumPeriodLength','var'); maximumPeriodLength = Settings.Random.MaximumPeriodLength; end
            
            algoTrader.MinimumPeriodLength = minimumPeriodLength;
            algoTrader.MaximumPeriodLength = maximumPeriodLength;
            algoTrader.Dummy = [];
            
            % Events
            addlistener(algoTrader, 'MinimumPeriodLength', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'MaximumPeriodLength', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Dummy', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
end
