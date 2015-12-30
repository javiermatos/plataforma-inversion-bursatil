
%% Create workspace variables

fts = struct;
for i = 1:length(symbolArray)
    
    % Get symbol
    symbol = symbolArray{i}{1};
    parameters = symbolArray{i}{2};
    symbolTag = lower(strrep(symbol, '^', ''));
    
    fprintf('Symbol %s... ', symbol);
    
    % FinancialTimeSerie
    fts = setfield( ...
        fts, ...
        symbolTag, ...
        FinancialTimeSerie.get(symbol,parameters{:}) ...
        );
    
    fprintf('done\n');
    
end

% Clean useless variables
clear symbolArray startDate             % outside loop
clear i symbol parameters symbolTag     % inside loop


engineSet = struct;
for i = 1:length(tradingEngineArray)
    
    % Engine name
    engineTag = tradingEngineArray{i}{1};
    engineHandle = tradingEngineArray{i}{2};
    
    fprintf('%s... ', func2str(engineHandle));
    
    fieldnameArray = fieldnames(fts);
    for j = 1:length(fieldnameArray)
        
        % Get symbol
        symbol = getfield(getfield(fts,fieldnameArray{j}),'Symbol');
        symbolTag = lower(strrep(symbol, '^', ''));
        
        % engineSet
        engineSet = setfield(engineSet,symbolTag,engineHandle(getfield(fts,fieldnameArray{j})));
        
    end
    
    assignin( ...
        'base', ...
        engineTag, ...
        engineSet ...
        );
    
    fprintf('done\n');
    
end

% Clean useless variables
clear tradingEngineArray engineSet              % outside loop
clear i engineTag engineHandle fieldnameArray   % outer loop
clear j symbol symbolTag engine                 % inner loop
