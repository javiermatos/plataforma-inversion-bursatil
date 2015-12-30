
function simulate(algoTrader)


serie = algoTrader.DataSerie.Serie;

signal = sign(diff(serie));
signal = [signal signal(end)];

algoTrader.Signal = signal;

end
