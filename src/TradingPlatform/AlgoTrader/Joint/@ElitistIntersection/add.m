
function add(algoTrader, varargin)

% Same DataSerie check
N = length(varargin);
for i = 1:N
    if ~algoTrader.DataSerie.equals(varargin{i}.DataSerie)
        error('Error: DataSerie must be the same for every AlgoTrader');
    end
end

% Clone algoTrader and store a local copy
newAlgoTrader = cell(N, 1);
for i = 1:N
    newAlgoTrader{i} = varargin{i}.clone();
end

% Add new algoTraders
algoTrader.InnerAlgoTrader = [algoTrader.InnerAlgoTrader ; newAlgoTrader ];

% Update Selection
algoTrader.Selection = [algoTrader.Selection ; 1];

% Update dynamic properties
algoTrader.updateDynamicProperties();

end
