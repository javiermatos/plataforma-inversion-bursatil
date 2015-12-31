
function computeSignal(algoTrader)

% Parameters
ratio = algoTrader.Ratio;

% Minimum votes to allow a position
minimumVotes = ratio*length(algoTrader.InnerAlgoTrader);

innerSignal = cellfun(@(algoTrader) algoTrader.Signal, algoTrader.InnerAlgoTrader, 'UniformOutput', false);

N = length(innerSignal);
S = length(algoTrader.DataSerie.Serie);

longPositionVotes = zeros(1,S);
for i = 1:N
    longPositionVotes = longPositionVotes + (innerSignal{i} == 1);
end

shortPositionVotes = zeros(1,S);
for i = 1:N
    shortPositionVotes = shortPositionVotes + (innerSignal{i} == -1);
end

noPositionVotes = zeros(1,S);
for i = 1:N
    noPositionVotes = noPositionVotes + (innerSignal{i} == 0);
end

signal = zeros(1,S);
signal(longPositionVotes>=minimumVotes & longPositionVotes>shortPositionVotes & longPositionVotes>noPositionVotes) = 1;
signal(shortPositionVotes>=minimumVotes & shortPositionVotes>longPositionVotes & shortPositionVotes>noPositionVotes) = -1;
%signal(shortPositionVotes>=minimumVotes & noPositionVotes>longPositionVotes & noPositionVotes>shortPositionVotes) = 0;

% Set Signal property
algoTrader.Signal = signal;

end
