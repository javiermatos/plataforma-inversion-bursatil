
function profitLossPerPosition = computeProfitLossPerPosition(te, set)

% var
if ~exist('set','var'); set = 'all'; end

% position
[longPosition, shortPosition, noPosition, serie] = te.computePositionsSerie(set);

% Check function to apply
switch lower(te.Measurement)
    
    case 'relative'
        
        lpfun = @(serie, longPosition, i) ...
            (serie(longPosition(i,2)) - serie(longPosition(i,1))) / serie(longPosition(i,1));
        
        spfun = @(serie, shortPosition, i) ...
            (serie(shortPosition(i,1)) - serie(shortPosition(i,2))) / serie(shortPosition(i,1));
        
    case 'absolute'
        
        lpfun = @(serie, longPosition, i) ...
            serie(longPosition(i,2)) - serie(longPosition(i,1));
        
        spfun = @(serie, shortPosition, i) ...
            serie(shortPosition(i,1)) - serie(shortPosition(i,2));
    
end

% Profit/Loss in long positions
plLongPosition = zeros(size(longPosition,1),1);
for i = 1:size(longPosition,1)
    % Relative/Absolute Profit/Loss
    plLongPosition(i) = lpfun(serie, longPosition, i);
end

% Profit/Loss in short positions
plShortPosition = zeros(size(shortPosition,1),1);
for i = 1:size(shortPosition,1)
    % Relative/Absolute Profit/Loss
    plShortPosition(i) = spfun(serie, shortPosition, i);
end

% Profit/Loss in no positions
%plNoPosition = zeros(size(noPosition,1),1);

profitLossPerPosition = ...
    [ ...
        [ ones(size(longPosition,1),1) longPosition plLongPosition ] ;
        [ -ones(size(shortPosition,1),1) shortPosition plShortPosition ] ; ...
        [ zeros(size(noPosition,1),1) noPosition zeros(size(noPosition,1),1) ] ...
    ];
profitLossPerPosition = sortrows(profitLossPerPosition,2);

end
