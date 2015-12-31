
function performance = worstRun(positionsLog)

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

isLoss = profitLoss<1;

index = [0 find(diff(isLoss')) length(isLoss)];

range = [index(1:end-1)'+1 index(2:end)'];

range = range(isLoss(range(:,1)) == 1,:);

performance = 1;

for i = 1:size(range,1)
    
    loss = prod(profitLoss(range(i,1):range(i,2)));
    
    if loss < performance
        performance = loss;
    end
    
end

end
