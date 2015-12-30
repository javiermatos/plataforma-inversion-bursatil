
function remove(algoTrader, varargin)

algoTrader.Set([varargin{:}]) = [];

% Update dynamic properties
algoTrader.updateDynamicProperties();

end
