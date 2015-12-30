
function add(algoTrader, varargin)

% Same DataSerie check
N = length(varargin);
for i = 1:N
    if ~algoTrader.DataSerie.equals(varargin{i}.DataSerie)
        error('DataSerie must be the same for all the algoTraders.');
    end
end

% Set is a column vector

% Just save a handle
%algoTrader.Set = varargin';

% Clone algoTrader and store a local copy
addedSet = cell(N, 1);
for i = 1:N
    addedSet{i} = varargin{i}.clone();
end

% Add new algoTraders
algoTrader.Set = [algoTrader.Set ; addedSet];

% Update dynamic properties
algoTrader.updateDynamicProperties();

end
