
function performance = bestRun(positionsLog)

% [ ...
%     positionType, ...
%     openIndex, ...
%     closeIndex, ...
%     openDate, ...
%     closeDate, ...
%     openPrice, ...
%     closePrice, ...
%     profitLoss ...
% ] ...
% = positionsLog;

profitLoss = positionsLog(:,8);

isProfit = profitLoss>=1;

index = [0 find(diff(isProfit')) length(isProfit)];

range = [index(1:end-1)'+1 index(2:end)'];

range = range(isProfit(range(:,1)) == 1,:);

performance = 1;

for i = 1:size(range,1)
    
    profit = prod(profitLoss(range(i,1):range(i,2)));
    
    if profit > performance
        performance = profit;
    end
    
end

end
