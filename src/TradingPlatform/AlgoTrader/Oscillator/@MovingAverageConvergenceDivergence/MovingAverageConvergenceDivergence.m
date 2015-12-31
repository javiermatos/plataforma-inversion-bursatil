
classdef MovingAverageConvergenceDivergence < Oscillator
    
    
    properties (GetAccess = public, SetAccess = public, SetObservable, AbortSet)
        
        Mode
        
        Lead
        
        Lag
        
        Samples
        
    end
    
    
%     %% LeadLag
%     properties (Dependent = true)
%         
%         LeadLag  % To use with optimization functions
%         
%     end
%     
%     methods
%         
%         % LeadLag SET
%         function set.LeadLag(algoTrader, LeadLag)
%             algoTrader.Lead = LeadLag(1);
%             algoTrader.Lag = LeadLag(2);
%         end
%         
%     end
    
    
    methods (Access = public)
        
        function algoTrader = MovingAverageConvergenceDivergence(dataSerie, mode, lead, lag, samples)
            
            algoTrader = algoTrader@Oscillator(dataSerie);
            
            if ~exist('mode','var'); mode = Default.MovingAverageConvergenceDivergence.Mode; end
            if ~exist('lead','var'); lead = Default.MovingAverageConvergenceDivergence.Lead; end
            if ~exist('lag','var'); lag = Default.MovingAverageConvergenceDivergence.Lag; end
            if ~exist('samples','var'); samples = Default.MovingAverageConvergenceDivergence.Samples; end
            
            algoTrader.Mode = mode;
            algoTrader.Lead = lead;
            algoTrader.Lag = lag;
            algoTrader.Samples = samples;
            
            % Events
            addlistener(algoTrader, 'Mode', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Lead', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Lag', 'PostSet', @algoTrader.resetSignal);
            addlistener(algoTrader, 'Samples', 'PostSet', @algoTrader.resetSignal);
            
        end
        
        
        [macd, signal, histogram, leadMovingAverage, lagMovingAverage] ...
            = bareOutput(algoTrader, initIndex, endIndex)
        
        computeSignal(algoTrader)
        
        %step(algoTrader)
        
    end
    
    
    methods (Access = protected)
        
        drawSeriePosition(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
        drawOscillator(algoTrader, axesHandle, setSelector, initIndex, endIndex)
        
    end
    
    
end
