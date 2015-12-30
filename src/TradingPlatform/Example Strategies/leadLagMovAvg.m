
function signal = leadLagMovAvg(stockQuotes, lead, lag)

% Width size to compute moving average
% if nargin < 2, lead = 50; end
% if nargin < 3, lag = 200; end

% Moving Average
[leading, lagging] = movavg(stockQuotes,lead,lag);

% Signal calculation
signal = zeros(1,length(leading));
signal(leading>lagging) = 1;    % Buy signal
signal(leading<lagging) = -1;   % Sell signal

% Values in lagging(1:lag) are not good. This is because it will consider a
% 0 value for those first elements in the calculation. For example if lag
% value is N and you are calculating lagging for a value lower than N then
% it is done by appending zero values vector to the head of the stockQuotes
% vector as needed. Values of the lagging vector that are in higher
% positions than lag value are correct.
signal(1:lag) = 0;

end
