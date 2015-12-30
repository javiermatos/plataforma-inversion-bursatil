
function simulate(algoTrader)

setSignal = cellfun(@(algoTrader) algoTrader.Signal, algoTrader.Set, 'UniformOutput', false);

N = length(algoTrader.Set);
S = length(algoTrader.DataSerie.Serie);

longPosition = ones(1,S);
for i = 1:N
    longPosition = longPosition & (setSignal{i} == 1);
end

shortPosition = ones(1,S);
for i = 1:N
    shortPosition = shortPosition & (setSignal{i} == -1);
end

% noPosition = ones(1,S);
% for i = 1:N
%     noPosition = noPosition & (setSignal{i} == 0);
% end

signal = zeros(1,S);
signal(longPosition) = 1;
signal(shortPosition) = -1;
% signal(noPosition) = 0;

algoTrader.Signal = signal;

end
