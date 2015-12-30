
% Presentation


%% Get some data from Yahoo Finance!

stockData = getStockDataYahoo('ibm')

% Oldest date
disp(['Oldest date: ', datestr(stockData.date(1))]);

% Newest date
disp(['Newest date: ', datestr(stockData.date(end))]);

%% Show stock data

nValues = 800;

% Convert data to fts object (MATLAB default object for Financial Toolbox)
fts = struct2mfts(stockData);

% Simple plot
figure('Name','Simple plot');
plot(fts(end-nValues:end));

% Interactive display
chartfts(fts(end-nValues:end));

% Candlesticks
figure('Name','Candlesticks');
candle(fts(end-nValues:end));

% Price and volume chart
figure('Name','Price and volume chart');
volarea([stockData.date(end-nValues:end) stockData.close(end-nValues:end) stockData.volume(end-nValues:end)]);
legend('volume','stock quote');

%% Indicators

leading = 11;
lagging = 23;

% Bollinger band
figure('Name','Bollinger band');
bolling(stockData.close(end-nValues:end), lagging);
legend('stock quote','moving average','n × deviation');

% Moving average
figure('Name','Moving average');
movavg(stockData.close(end-nValues:end), leading, lagging);
legend('stock quote','lagging','leading');

% Relative Strength Index
figure('Name','Relative Strength Index');
subplot(2,1,1);
plot(stockData.close(end-nValues:end));
legend('stock quote');
subplot(2,1,2);
hold on;
plot(rsindex(stockData.close(end-nValues:end)),'r');
plot([0 nValues], [70, 70],'k');
plot([0 nValues], [30, 30],'k');
hold off;
legend('RSI');

%% Lead/Lag Moving Average

%leadLagMovAvgScript;

%% Optimum lead/lag values
[leading, lagging] = optimumLeadLagValues(stockData.close, 100, 1:100);

% Leading values
leading

% Lagging values
lagging

signal = leadLagMovAvg(stockData.close, leading, lagging);

profitLossSerie(stockData.close, signal);

%% Dynamic optimum lead/lag values

[output, fitnessMatrix] = dynamicOptimumLeadLagValues1(stockData.close,250,125,2235,1:50);

fitnessMatrix2Animation(fitnessMatrix, 3);
