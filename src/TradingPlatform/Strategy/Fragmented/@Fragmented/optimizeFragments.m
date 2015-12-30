
function optimizeFragments(algoTrader, varargin)

% We cannot use parfor here because it is not computed correctly
for i = 1:length(algoTrader.Fragment)
    algoTrader.Fragment(i).optimize(varargin{:});
end

end
