
function stockData = flipStockData(stockData)

stockData.date = flipud(stockData.date);
stockData.open = flipud(stockData.open);
stockData.high = flipud(stockData.high);
stockData.low = flipud(stockData.low);
stockData.close = flipud(stockData.close);
stockData.volume = flipud(stockData.volume);

% Only Yahoo gives this field but no Google
if isfield(stockData,'rawclose')
    stockData.rawclose = flipud(stockData.rawclose);
end

end
