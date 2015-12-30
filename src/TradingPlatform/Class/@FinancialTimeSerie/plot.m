
function fig = plot(fts, startRange, endRange, fun)

% startRange
if ~exist('startRange','var'); startRange = 1; end
% endRange
if ~exist('endRange','var'); endRange = fts.Length; end
% fun
if ~exist('fun','var'); fun = @(x) x; end


% Description
[startIndex, endIndex] = fts.range2index(startRange, endRange);
description = ...
    [fts.Symbol, ' - ', fts.Frecuency, ...
    ' from ', datestr(fts.Date(startIndex)), ...
    ' to ', datestr(fts.Date(endIndex))];

% Figure handle
figureHandle = figure( ...
    'Name', description, ...
    'NumberTitle', 'off', ...
    'Color', Default.BackgroundColor ...
    );

% Serie
serie = subplot(2,1,1);
%set(serie, 'Tag', 'Layer');
fts.plotSerie(startRange, endRange, fun, serie);

% Volume
volume = subplot(2,1,2);
%set(volume, 'Tag', 'Layer');
fts.plotVolume(startRange, endRange, volume);

% Link axes views over x
linkaxes([serie, volume],'x');

% Corrections
plotCorrection(figureHandle);

% Output
if nargout == 1
    fig = figureHandle;
end

end
