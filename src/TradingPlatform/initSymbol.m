
%% Create workspace variables

fts = struct;
for i = 1:length(symbolArray)
    
    % Get symbol
    symbol = symbolArray{i}{1};
    parameters = symbolArray{i}{2};
    symbolTag = lower(strrep(symbol, '^', ''));
    
    fprintf('Symbol %s... \n', symbol);
    
    % FinancialTimeSerie
    fts = setfield( ...
        fts, ...
        symbolTag, ...
        FinancialTimeSerie.get(symbol,parameters{:}) ...
        );
    
    engineSet = struct;
    for j = 1:length(tradingEngineArray)
        
        % Engine name
        engineTag = tradingEngineArray{j}{1};
        engineHandle = tradingEngineArray{j}{2};
        
        fprintf(' %s... ', func2str(engineHandle));
        
        engineSet = setfield(engineSet,engineTag,engineHandle(getfield(fts,symbolTag)));
        
        fprintf('done\n');
        
    end
    
    assignin( ...
        'base', ...
        symbolTag, ...
        engineSet ...
        );
    
end

% Clean useless variables
clear i symbolArray symbol parameters symbolTag startDate engineSet
clear j tradingEngineArray engineTag engineHandle engine
