
% Load data
load('intraday');
x = data(:,4);

% Width size to compute moving average
lead = 50; lag = 200;
% Amount of data to show (between 0 and 1)
pshow = 0.01;

% Moving Average
[leading, lagging] = movavg(x,lead,lag);

% Generate graphics
clf;
%figure('Name','Strategy based on moving average');

% Some calculations
begining = floor((1-pshow)*length(x));
if begining == 0, begining = 1; end
% Signal calculation
signal = zeros(1,length(leading));
signal(leading>lagging) = 1;    % Buy signal
signal(leading<lagging) = -1;   % Sell signal

% Stock quote & moving average
subplot(3,1,1); hold on;
title(['Stock quote & moving average (lead=', num2str(lead), ',lag=', num2str(lag), ')']);
plot(begining:length(x),x(begining:end),'g');
plot(max(lead,begining):length(leading),leading(max(lead,begining):end),'r');
plot(max(lag,begining):length(lagging),lagging(max(lag,begining):end),'b');
xlim([begining length(x)]);
legend('stock quote','leading','lagging');

% Signal
subplot(3,1,2); hold on;
title('Signal');
plot(begining:length(signal),signal(begining:end),'k');
xlim([begining length(x)]);
ylim([-2 2]);

% Profit/Loss serie
subplot(3,1,3); hold on;
title('Profit/Loss serie');
plot(begining:length(signal),profitLossSerie(x(begining:end),signal(begining:end)));
xlim([begining length(x)]);
