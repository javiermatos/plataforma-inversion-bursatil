
function remove(algoTrader, varargin)

algoTrader.InnerAlgoTrader([varargin{:}]) = [];

% Update dynamic properties
algoTrader.updateDynamicProperties();

end
