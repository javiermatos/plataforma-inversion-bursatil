
function sh = sharpeRatio(profitLossSerie, benckmark)

% No benchmark argument
if nargin < 2, benckmark = 1.1; end

% Argument benchmark is a scalar or a valid vector
if length(benckmark) == 1 || length(profitLossSerie) == length(benckmark)
    
    sh = mean(profitLossSerie-benchmark)/std(profitLossSerie-benchmark);
    
else
    error('benchmark must be a scalar or a same sized vector.'); 
end

end
