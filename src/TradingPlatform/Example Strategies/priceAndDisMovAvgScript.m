
% Load data
load('intraday');
x = data(:,4);

% Width size to compute moving average
n = 600;
% Displacement
d = 100;
% Amount of data to show (between 0 and 1)
pshow = 0.01;

% Displaced Moving Average
avg = smovavg(x,n);
if d > 0
    avg = avg(1:end-d);
else
    avg = avg(abs(d)+1:end);
end

% Generate graphics
clf;
%figure('Name','Strategy based on displaced moving average');

% Some calculations
begining = floor((1-pshow)*length(x));
if begining == 0, begining = 1; end
% Signal calculation
signal = zeros(1,length(avg));
if d > 0
    signal(x(d+1:end)>avg) = 1;     % Buy signal
    signal(x(d+1:end)<avg) = -1;    % Sell signal
else
    signal(x(1:end+d)>avg) = 1;     % Buy signal
    signal(x(1:end+d)<avg) = -1;    % Sell signal
end

% Stock quote & moving average
subplot(2,1,1); hold on;
title(['Stock quote & displaced moving average (n=', num2str(n), ',d=', num2str(d,'%+d'), ')']);
plot(begining:length(x),x(begining:end),'g');
plot(max(n,begining)+d:length(avg)+d,avg(max(n,begining):end),'r');
xlim([begining length(x)]);

% Signal
subplot(2,1,2); hold on;
title('Signal');
plot(begining+d:length(signal)+d,signal(begining:end),'k');
xlim([begining length(x)]);
ylim([-2 2]);
