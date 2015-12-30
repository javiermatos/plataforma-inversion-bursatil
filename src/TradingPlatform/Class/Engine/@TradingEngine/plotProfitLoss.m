
function output = plotProfitLoss(te, startRange, endRange, axesHandle)

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = te.FinancialTimeSerie.Length; end

if ~exist('axesHandle','var'); axesHandle = []; end

baseOutput = plotWrapper(te, startRange, endRange, axesHandle, @plotProfitLossCustomizer);

% Define output argument if requested
if nargout == 1
    if isempty(axesHandle)
        output = baseOutput;
    else
        output = get(baseOutput, 'Parent');
    end
end

end
