
function stockData = matrix2struct(symb, freq, m)

stockData.symbol = symb;    % Description
stockData.frecuency = freq; % Frecuency

stockData.date = m(:,1);    % Date
stockData.open = m(:,2);    % Open
stockData.high = m(:,3);    % High
stockData.low = m(:,4);     % Low
stockData.close = m(:,5);   % Close
stockData.volume = m(:,6);  % Volume

end
