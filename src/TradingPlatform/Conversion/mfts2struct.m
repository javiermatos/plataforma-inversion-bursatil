
function stockData = mfts2struct(tsobj)

stockData.symbol = getfield(tsobj, 'desc');                     % Description
stockData.frecuency = lower(freqstr(getfield(tsobj, 'freq')));  % Frecuency

stockData.date = getfield(tsobj, 'dates');      % Date
stockData.open = getfield(tsobj, 'open');       % Open
stockData.high = getfield(tsobj, 'high');       % High
stockData.low = getfield(tsobj, 'low');         % Low
stockData.close = getfield(tsobj, 'close');     % Close
stockData.volume = getfield(tsobj, 'volume');   % Volume

end
