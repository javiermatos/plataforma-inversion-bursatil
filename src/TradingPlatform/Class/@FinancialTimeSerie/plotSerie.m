
function output = plotSerie(fts, startRange, endRange, fun, axesHandle)

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = fts.Length; end
% fun
if ~exist('fun','var'); fun = @(x) x; end
% axesHandle
if ~exist('axesHandle','var'); axesHandle = []; end

baseOutput = plotWrapper(fts, startRange, endRange, axesHandle, @plotSerieCustomizer, fun);

% Define output argument if requested
if nargout == 1
    if isempty(axesHandle)
        output = baseOutput;
    else
        output = get(baseOutput, 'Parent');
    end
end

end
