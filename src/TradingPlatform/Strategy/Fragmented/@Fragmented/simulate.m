
function simulate(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% Signal
signal = zeros(1, length(serie));

% Signal from first fragment
initialIndex = algoTrader.InitialIndex;
splitIndex = min(initialIndex+algoTrader.Size-1, algoTrader.DataSerie.Length);
signal(initialIndex:splitIndex) = algoTrader.Fragment(1).Signal(initialIndex:splitIndex);

for i = 2:length(algoTrader.Fragment)
    
    initialIndex = max ...
        ( ...
            algoTrader.InitialIndex+(i-1)*algoTrader.Jump, ...
            algoTrader.Fragment(i-1).SplitIndex+1 ...
        );
    
    splitIndex = min ...
        ( ...
            initialIndex+algoTrader.Size-1, ...
            algoTrader.DataSerie.Length ...
        );
    
    signal(initialIndex:splitIndex) = algoTrader.Fragment(i).Signal(initialIndex:splitIndex);
    
end

% Set Signal property
algoTrader.Signal = signal;

end
