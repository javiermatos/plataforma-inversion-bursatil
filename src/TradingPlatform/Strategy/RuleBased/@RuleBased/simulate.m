
function simulate(algoTrader)

serie = algoTrader.DataSerie;

command = [regexprep(algoTrader.Command, '&', 'algoTrader.DataSerie.') ';'];
buyRule = regexprep(algoTrader.BuyRule, '&', 'algoTrader.DataSerie.');
sellRule = regexprep(algoTrader.SellRule, '&', 'algoTrader.DataSerie.');

% Evaluate command
eval(command);

% Signal
signal = zeros(1, length(serie));
signal(eval(buyRule)) = 1;
signal(eval(sellRule)) = -1;

% Set Signal property
algoTrader.Signal = signal;

end
