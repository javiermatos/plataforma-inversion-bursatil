
function fig = plotl(fts, startRange, endRange)

if ~exist('startRange','var'); startRange = 1; end
if ~exist('endRange','var'); endRange = fts.Length; end

if nargout == 1
    fig = fts.plot(startRange, endRange, @log);
else
    fts.plot(startRange, endRange, @log);
end

end
