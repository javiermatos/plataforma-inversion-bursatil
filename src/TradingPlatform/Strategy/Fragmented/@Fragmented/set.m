
function set(algoTrader, varargin)

propertyName = varargin(1:2:end);
propertyValue = varargin(2:2:end);

for i = 1:length(algoTrader.Fragment)
    
    for j = 1:length(propertyName)
        
        subsasgn( ...
            algoTrader.Fragment(i), ...
            struct('type','.','subs',propertyName{j}), ...
            propertyValue{j} ...
            );
        
    end
    
end

end
