
function pick(symbol)

if isempty(whos('global','globalData'))
    error('Global variable ''data'' not found.');
end

global globalData;

% Search for the correct index
index = find(symbol, globalData);

if index == -1
    error('Symbol not found.');
end

% Clear variables
%clear fts te rnd mac matc

% Prefix
separator = '';
prefix = [lower(strrep(globalData{index}.fts.Symbol, '^', '')), separator];

% Load the FinancialTimeSerie
assignin( ...
    'base', ...
    [prefix, 'fts'], ...
    globalData{index}.fts ...
    );

% Load every TradingEngine into the workspace
fieldNames = fieldnames(globalData{index});
for i = 1:length(fieldNames)
    
    fieldString = char(fieldNames{i});
    
    if isa(getfield(globalData{index}, fieldString), 'TradingEngine')
        assignin( ...
            'base', ...
            [prefix, fieldString], ...
            getfield(globalData{index}, fieldString) ...
            );
    end
    
end

end

function index = find(symbol, data)

index = -1;
for i = 1:length(data)
    if strcmpi(strrep(symbol, '^', ''), strrep(data{i}.symbol, '^', ''))
        index = i;
        break;
    end
end

end
