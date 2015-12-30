
function fts = struct2fts(s)

fts = FinancialTimeSerie(s.symbol, s.frecuency, s.date, s.open, s.high, s.low, s.close, s.volume);

end
