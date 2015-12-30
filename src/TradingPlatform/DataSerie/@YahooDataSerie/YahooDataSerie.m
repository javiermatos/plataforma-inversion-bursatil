
classdef YahooDataSerie < DataSerie
    
    
    %% Public methods
    methods (Access = public)
        
        
        %% Constructor
        function dataSerie = YahooDataSerie( ...
            symbolCode, compressionType, compressionUnits, ...
            initDateTime, endDateTime ...
            )
            
            if ~exist('initDateTime','var'); initDateTime = []; end
            if ~exist('endDateTime','var'); endDateTime = []; end
            
            dataSerie = dataSerie@DataSerie( ...
                symbolCode, compressionType, compressionUnits, ...
                initDateTime, endDateTime ...
                );
            
        end
        
        
    end
    
    
    %% Public static methods
    methods (Access = protected, Static)
        
        [dateTime, open, high, low, close, volume] = get(symbolCode, compressionType, compressionUnits, initDateTime, endDateTime)
        
    end
    
    
end
