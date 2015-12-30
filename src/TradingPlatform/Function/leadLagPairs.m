
function pairs = leadLagPairs(values)

N = length(values);

leadArray = arrayfun(@(value, n) repmat(value,1,n), values(1:end-1), N-1:-1:1, 'UniformOutput', 0);
leadArray = [leadArray{:}];
lagArray = arrayfun(@(index) values(index:end) , 2:N, 'UniformOutput', 0);
lagArray = [lagArray{:}];

pairs = arrayfun(@(lead, lag) [lead lag], leadArray, lagArray, 'UniformOutput', 0)';

end
