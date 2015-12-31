
function computeSignal(algoTrader)

% Parameters
serie = algoTrader.DataSerie.Serie;

% Signal
signal = zeros(1, length(serie));

for i = 1:length(algoTrader.Fragment)
    
    % Test set of the current fragment
    testSet = algoTrader.Fragment(i).TestSet;
    
    % Copy signal generated for the test fragment
    signal(testSet(1):testSet(2)) = algoTrader.Fragment(i).Signal(testSet(1):testSet(2));
    
end

% Set Signal property
algoTrader.Signal = signal;

end
