
function [startIndex, endIndex] = range2index(fts, startRange, endRange)

% startRange
if ~exist('startRange','var'); startRange = 1; end
if isnumeric(startRange)
    startIndex = startRange;
elseif ischar(startRange)
    startIndex = find(datenum(startRange) <= fts.Date, 1, 'first');
end

% endRange
if ~exist('endRange','var'); endRange = fts.Length; end
if isnumeric(endRange)
    endIndex = endRange;
elseif ischar(endRange)
    endIndex = find(datenum(endRange) >= fts.Date, 1, 'last');
end

end
