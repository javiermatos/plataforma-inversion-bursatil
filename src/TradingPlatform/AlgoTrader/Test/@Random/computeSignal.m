
function computeSignal(algoTrader)

% Minimum/Maximum Period Length
minimumPeriodLength = algoTrader.MinimumPeriodLength;
maximumPeriodLength = algoTrader.MaximumPeriodLength;
wideLength = maximumPeriodLength - minimumPeriodLength;
length = algoTrader.DataSerie.Length;

signal = zeros(1, length);

i = 1;
while i <= length
    
    j = round(rand()*wideLength)+minimumPeriodLength;
    signal(i:i+j) = randi(3)-2;
    
    i = i+j+1;
    
end

% Cut to fit the size
signal = signal(1:length);

% Set Signal property
algoTrader.Signal = signal;

% % Shortest version
% algoTrader.Signal = randi(3, 1, algoTrader.DataSerie.Length)-2;

end
