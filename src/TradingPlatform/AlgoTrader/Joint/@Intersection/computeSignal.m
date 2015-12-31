
function computeSignal(algoTrader)

innerSignal = cellfun(@(algoTrader) algoTrader.Signal, algoTrader.InnerAlgoTrader, 'UniformOutput', false);

N = length(innerSignal);
S = length(algoTrader.DataSerie.Serie);

longPosition = ones(1,S);
for i = 1:N
    longPosition = longPosition & (innerSignal{i} == 1);
end

shortPosition = ones(1,S);
for i = 1:N
    shortPosition = shortPosition & (innerSignal{i} == -1);
end

% noPosition = ones(1,S);
% for i = 1:N
%     noPosition = noPosition & (innerSignal{i} == 0);
% end

signal = zeros(1,S);
signal(longPosition) = 1;
signal(shortPosition) = -1;
% signal(noPosition) = 0;

algoTrader.Signal = signal;

end
