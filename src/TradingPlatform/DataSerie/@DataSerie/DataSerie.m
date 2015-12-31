
classdef DataSerie < handle
    
    
    %% Properties
    properties (GetAccess = public, SetAccess = private)
        
        SymbolCode          % Symbol name
        
        CompressionType     % Compression type
        
        CompressionUnits    % Compression units
        
        DateTime            % Date
        
        Open                % Open price
        
        High                % Highest price
        
        Low                 % Lowest price
        
        Close               % Close price
        
        Volume              % Transaction volume
        
    end
    
    
    %% Dependent properties
    properties (Dependent = true)
        
        Serie           % Default price serie that engines will use.
        
        DiffSerie       % Diff serie
        
        InitDateTime    % First date in serie
        
        EndDateTime     % Last date in serie
        
        Length          % Length of arrays
        
    end
    
    methods
        
        % Serie GET
        function Serie = get.Serie(dataSerie)
            Serie = dataSerie.Close;
        end
        
        % DiffSerie GET
        function DiffSerie = get.DiffSerie(dataSerie)
            serie = dataSerie.Serie;
            DiffSerie = [0 diff(serie)./serie(1:end-1)];
			%DiffSerie = [0 diff(serie)-serie(1:end-1)];
        end
        
        % InitDateTime GET
        function InitDateTime = get.InitDateTime(dataSerie)
            InitDateTime = datestr(dataSerie.DateTime(1));
        end
        
        % EndDateTime GET
        function EndDateTime = get.EndDateTime(dataSerie)
            EndDateTime = datestr(dataSerie.DateTime(end));
        end
        
        % Length GET
        function Length = get.Length(dataSerie)
            Length = length(dataSerie.Serie);
        end
        
    end
    
    
    %% Public methods
    methods (Access = public)
        
        
        %% Constructor
        function dataSerie = DataSerie( ...
            symbolCode, compressionType, compressionUnits, ...
            initDateTime, endDateTime ...
            )
            
            dataSerie.SymbolCode = symbolCode;
            dataSerie.CompressionType = compressionType;
            dataSerie.CompressionUnits = compressionUnits;
            
            [ ...
                dataSerie.DateTime, ...
                dataSerie.Open, ...
                dataSerie.High, ...
                dataSerie.Low, ...
                dataSerie.Close, ...
                dataSerie.Volume ...
            ] ...
            = dataSerie.get(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime);
            
            % Transform to row column
            dataSerie.DateTime = dataSerie.DateTime';
            dataSerie.Open = dataSerie.Open';
            dataSerie.High = dataSerie.High';
            dataSerie.Low = dataSerie.Low';
            dataSerie.Close = dataSerie.Close';
            dataSerie.Volume = dataSerie.Volume';
            
        end
        
        
        %% Methods
        
        boolean = equals(lhs, rhs)
        
        fig = plotWrapper(dataSerie, customizer, axesHandle, rangeInit, rangeEnd, varargin)
        
        fig = plot(dataSerie, rangeInit, rangeEnd)
        
        fig = plotOpen(dataSerie, rangeInit, rangeEnd)
        
        fig = plotHigh(dataSerie, rangeInit, rangeEnd)
        
        fig = plotLow(dataSerie, rangeInit, rangeEnd)
        
        fig = plotClose(dataSerie, rangeInit, rangeEnd)
        
        fig = plotVolume(dataSerie, rangeInit, rangeEnd)
        
        fig = plotSerie(dataSerie, rangeInit, rangeEnd)
        
        fig = plotSeries(dataSerie, rangeInit, rangeEnd)
        
        fig = plotDiffSerie(dataSerie, rangeInit, rangeEnd)
        
        index = firstFrom(dataSerie, dateTime)
        
        index = lastUntil(dataSerie, dateTime)
        
        
    end
    
    methods (Access = protected)
        
        %fig = plotWrapper(dataSerie, customizer, axesHandle, rangeInit, rangeEnd, varargin)
        
        drawOpen(dataSerie, axesHandle, initIndex, endIndex)
        
        drawHigh(dataSerie, axesHandle, initIndex, endIndex)
        
        drawLow(dataSerie, axesHandle, initIndex, endIndex)
        
        drawClose(dataSerie, axesHandle, initIndex, endIndex)
        
        drawVolume(dataSerie, axesHandle, initIndex, endIndex)
        
        drawSerie(dataSerie, axesHandle, initIndex, endIndex)
        
        drawSeries(dataSerie, axesHandle, initIndex, endIndex)
        
        drawDiffSerie(dataSerie, axesHandle, initIndex, endIndex)
        
    end
    
    
    %% Public static abstract methods
    methods (Access = protected, Static, Abstract)
        
        [dateTime, open, high, low, close, volume] = get(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)
        
    end
    
    
end
