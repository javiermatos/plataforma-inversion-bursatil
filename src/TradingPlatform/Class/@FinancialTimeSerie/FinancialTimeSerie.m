
classdef FinancialTimeSerie < handle
    
    
    %% Symbol, Frecuency, Date, Open, High, Low, Close, Volume
    properties (GetAccess = public, SetAccess = private)
        
        Symbol          % Symbol name
        
        Frecuency       % Data frecuency
        
        Date            % Date
        
        Open            % Open price
        
        High            % Highest price
        
        Low             % Lowest price
        
        Close           % Close price
        
        Volume          % Transaction volume
        
    end
    
    
    %% Dependent properties
    properties (Dependent = true)
        
        Length          % Length of arrays
        
        Serie           % Default price serie that engines will use
        
    end
    
    methods
        
        % Length GET
        function Length = get.Length(fts)
            Length = length(fts.Serie);
        end
        
        % Serie GET
        function Serie = get.Serie(fts)
            Serie = fts.Close;
        end
        
    end
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function fts = FinancialTimeSerie(symbol, frecuency, date, open, high, low, close, volume)
            
            fts.Symbol = symbol;
            fts.Frecuency = frecuency;
            fts.Date = date;
            fts.Open = open;
            fts.High = high;
            fts.Low = low;
            fts.Close = close;
            %fts.Close = (1:length(low))';
            fts.Volume = volume;
            
        end
        
        
        %% Methods
        
        ftsSubset = subset(fts, startRange, endRange)
        
        [startIndex, endIndex] = range2index(fts, startRange, endRange)
        
        
        %% Methods that can be reimplemented in subclasses
        fig = plot(fts, startRange, endRange, fun)
        
        fig = plotl(fts, startRange, endRange)
        
        output = plotSerie(te, startRange, endRange, fun, axesHandle)
        
        output = plotVolume(te, startRange, endRange, axesHandle)
        
        
    end
    
    
    %% Public class methods
    methods (Access = public, Static)
        
        fts = get(symbol, varargin);
        
    end
    
    
end
