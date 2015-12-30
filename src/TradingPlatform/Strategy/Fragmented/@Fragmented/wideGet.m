
function values = wideGet(algoTrader, varargin)

values = cell(1, length(varargin));
for i = 1:length(varargin)
    values{i} = cell(1, length(algoTrader.Fragment));
end

for i = 1:length(algoTrader.Fragment)
    
    for j = 1:length(varargin)
        
        values{j}{i} = subsref(...
            algoTrader.Fragment(i), ...
            struct('type','.','subs',varargin{j}) ...
            );
        
    end
    
end

end
