
function output = plotVolume(fts, startRange, endRange, axesHandle)

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = fts.Length; end
% axesHandle
if ~exist('axesHandle','var'); axesHandle = []; end

baseOutput = plotWrapper(fts, startRange, endRange, axesHandle, @plotVolumeCustomizer);

% Define output argument if requested
if nargout == 1
    if isempty(axesHandle)
        output = baseOutput;
    else
        output = get(baseOutput, 'Parent');
    end
end

end
