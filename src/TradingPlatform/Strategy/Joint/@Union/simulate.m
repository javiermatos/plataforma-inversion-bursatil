
function simulate(algoTrader)

votes = algoTrader.Votes;

setSignal = cellfun(@(algoTrader) algoTrader.Signal, algoTrader.Set, 'UniformOutput', false);

N = length(algoTrader.Set);
S = length(algoTrader.DataSerie.Serie);

longPositionVotes = zeros(1,S);
for i = 1:N
    longPositionVotes = longPositionVotes + (setSignal{i} == 1);
end

shortPositionVotes = zeros(1,S);
for i = 1:N
    shortPositionVotes = shortPositionVotes + (setSignal{i} == -1);
end

noPositionVotes = zeros(1,S);
for i = 1:N
    noPositionVotes = noPositionVotes + (setSignal{i} == 0);
end

signal = zeros(1,S);
signal(longPositionVotes>=votes & longPositionVotes>shortPositionVotes & longPositionVotes>noPositionVotes) = 1;
signal(shortPositionVotes>=votes & shortPositionVotes>longPositionVotes & shortPositionVotes>noPositionVotes) = -1;
%signal(shortPositionVotes>=votes & noPositionVotes>longPositionVotes & noPositionVotes>shortPositionVotes) = 0;

algoTrader.Signal = signal;

end
