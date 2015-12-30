
% Calculate Profit/Loss
function profitLoss = computeProfitLoss(te, set)

% set
if ~exist('set','var'); set = 'all'; end

% Exception for those situation with less money than needed
if te.Investment < min(te.FinancialTimeSerie.Serie)
    profitLoss = 0;
    return;
end

% position
[longPosition, shortPosition, ~, serie] = te.computePositionsSerie(set);
position = [];
if ~isempty(longPosition) || ~isempty(shortPosition)
    position = sortrows([[ones(size(longPosition, 1),1) longPosition]; [-ones(size(shortPosition, 1),1) shortPosition]], 2);
end

% function to apply
switch lower(te.Measurement)
    case 'relative'
        fun = @relativeProfitLoss;
    case 'absolute'
        fun = @absoluteProfitLoss;
end

% Available funds to invest
funds = te.Investment;

for i = 1:size(position,1)
    
    % Open position price
    open = serie(position(i,2));
    % Close position price
    close = serie(position(i,3));
    
    % Number of stocks that we can buy
    n = max(0,floor((funds-2*te.TradeCost)*te.Money2Tick/open));
    
    % Proceed only if we buy/sell
    if n > 0
        
        type = position(i,1);
        if type == 1
            % Long position
            funds = n*(close-open)*te.Tick2Money+funds-2*te.TradeCost;
        elseif type == -1
            % Short position
            funds = n*(open-close)*te.Tick2Money+funds-2*te.TradeCost;
        end
        
    end
    
end

profitLoss = fun(te.Investment, funds);

end

function profitLoss = relativeProfitLoss(funds0, funds)

profitLoss = (funds/funds0)-1;

end

function profitLoss = absoluteProfitLoss(funds0, funds)

profitLoss = funds-funds0;

end
