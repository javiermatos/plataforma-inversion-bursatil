
% Load data
load('intraday');
x = data(:,4);

% Width size to compute moving average
n = 600;
% Amount of data to show (between 0 and 1)
pshow = 0.01;

% Moving Average
avg = smovavg(x,n);

% Generate graphics
clf;
%figure('Name','Strategy based on moving average');

% Some calculations
begining = floor((1-pshow)*length(x));
if begining == 0, begining = 1; end
% Signal calculation
signal = zeros(1,length(avg));
signal(x>avg) = 1;  % Buy signal
signal(x<avg) = -1; % Sell signal

% Stock quote & moving average
subplot(2,1,1); hold on;
title(['Stock quote & moving average (n=', num2str(n), ')']);
plot(begining:length(x),x(begining:end),'g');
plot(max(n,begining):length(avg),avg(max(n,begining):end),'r');
xlim([begining length(x)]);

% Signal
subplot(2,1,2); hold on;
title('Signal');
plot(begining:length(signal),signal(begining:end),'k');
xlim([begining length(x)]);
ylim([-2 2]);
