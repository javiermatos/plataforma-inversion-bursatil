
function remove(algoTrader, varargin)

algoTrader.InnerAlgoTrader([varargin{:}]) = [];

% Update Selection
algoTrader.Selection([varargin{:}]) = [];

% Update dynamic properties
algoTrader.updateDynamicProperties();

end
