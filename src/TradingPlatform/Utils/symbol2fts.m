
function fts = symbol2fts(symbol)

fts = struct2fts(getStockDataYahoo(symbol));

end
