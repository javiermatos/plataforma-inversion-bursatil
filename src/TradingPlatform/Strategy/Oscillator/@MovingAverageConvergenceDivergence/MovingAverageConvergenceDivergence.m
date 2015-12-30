
classdef MovingAverageConvergenceDivergence < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Lead
        
        Lag
        
        SignalMode
        
        SignalSamples
        
    end
    
    
    %% LeadLag
    properties (Dependent = true)
        
        LeadLag  % To use with optimization functions
        
    end
    
    methods
        
        % LeadLag SET
        function set.LeadLag(algoTrader, LeadLag)
            algoTrader.Lead = LeadLag(1);
            algoTrader.Lag = LeadLag(2);
        end
        
    end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAverageConvergenceDivergence(dataSerie, mode, lead, lag, signalMode, signalSamples)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('mode','var'); mode = Settings.MovingAverageConvergenceDivergence.Mode; end
            if ~exist('lead','var'); lead = Settings.MovingAverageConvergenceDivergence.Lead; end
            if ~exist('lag','var'); lag = Settings.MovingAverageConvergenceDivergence.Lag; end
            if ~exist('signalMode','var'); signalMode = Settings.MovingAverageConvergenceDivergence.SignalMode; end
            if ~exist('signalSamples','var'); signalSamples = Settings.MovingAverageConvergenceDivergence.SignalSamples; end
            
            algoTrader.Mode = mode;
            algoTrader.Lead = lead;
            algoTrader.Lag = lag;
            algoTrader.SignalMode = signalMode;
            algoTrader.SignalSamples = signalSamples;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Lead', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Lag', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'SignalMode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'SignalSamples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        simulate(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
        drawOscillator(algoTrader, axesHandle, initIndex, endIndex, applySplit)
        
    end
    
    
end
