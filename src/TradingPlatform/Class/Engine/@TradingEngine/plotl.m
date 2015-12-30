
function fig = plotl(te, startRange, endRange)

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = te.FinancialTimeSerie.Length; end

if nargout == 1
    fig = te.plot(startRange, endRange, @log);
else
    te.plot(startRange, endRange, @log);
end

end
