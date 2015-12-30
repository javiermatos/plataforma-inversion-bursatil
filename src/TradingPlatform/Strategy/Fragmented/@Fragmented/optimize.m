
function optimize(algoTrader, varargin)

% We cannot use parfor here because it is not computed correctly
for i = 1:length(algoTrader.Fragment)
    algoTrader.Fragment(i).optimize(varargin{:});
end

% Pairs of property name and property value
pairs = varargin;
% Remove optimization method from pairs
if isa(pairs{1},'function_handle') ||  iscell(pairs{1})
    pairs = pairs(2:end);
end
% Remove fitness function from pairs
if isa(pairs{1},'function_handle') ||  iscell(pairs{1})
    pairs = pairs(2:end);
end

propertyName = pairs(1:2:end);
propertyValues = algoTrader.wideGet(propertyName{:});

for i = 1:length(propertyName)
    
    propertyValues{i} = ...
        [ ...
            subsref(algoTrader.AlgoTraderBase, struct('type','.','subs',propertyName{i})), ...
            propertyValues{i}(1:end-1) ...
        ];
    
end

input = cellfun(@(name, values) {name values}, propertyName, propertyValues, 'UniformOutput', false);
input = [input{:}];

algoTrader.wideSet(input{:});

end
