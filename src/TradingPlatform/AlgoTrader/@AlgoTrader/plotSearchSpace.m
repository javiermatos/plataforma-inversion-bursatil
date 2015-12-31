
function fig = plotSearchSpace(algoTrader, varargin)

% Default fitness function is built-in fitness which calls profitLoss
fitnessMethodWithArguments = {};

% Change default if requested in the call
if isa(varargin{1},'function_handle')
    fitnessMethodWithArguments = varargin(1);
    pairs = varargin(2:end);
elseif iscell(varargin{1})
    fitnessMethodWithArguments = varargin{1};
    pairs = varargin(2:end);
else
    pairs = varargin;
end

% There is no need to sort varargin to make it faster with parfor.
propertyName = pairs(1:2:end);
propertyDomain = pairs(2:2:end);
propertyDomainSize = cellfun(@length, pairs(2:2:end));

searchSpaceDimension = length(propertyName);

% Call optimization method
[~, searchSpace] = exhaustive ...
    ( ...
        @max, ...
        @(indexArray) fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray), ...
        propertyDomainSize ...
    );


% Plot searchSpace
% Set figure handle
figureHandle = figure();

% Axes of the current figure
axesHandle = axes();

%%%
if searchSpaceDimension == 1
    % For one dimension there is no need to sort anything, just
    % transpose the search space
    searchSpace = searchSpace';
else
    % Sort dimensions to provide a better representation
    [searchSpaceSize, index] = sort(propertyDomainSize, 'descend');
    
    wSize = searchSpaceSize(1); w = index(1);
    hSize = searchSpaceSize(2); h = index(2);
    
    for i = 3:length(index)
        if wSize < hSize
            wSize = wSize * searchSpaceSize(i);
            w = [w index(i)];
        else
            hSize = hSize * searchSpaceSize(i);
            h = [h index(i)];
        end
    end
    
    if hSize > wSize
        tmp = w;
        w = h;
        h = tmp;
    end
    
    searchSpace = permute(searchSpace, [h w]);
    searchSpace = reshape(searchSpace, prod(propertyDomainSize(h)), []);
    
    propertyName = propertyName([h w]);
    propertyDomain = propertyDomain([h w]);
    propertyDomainSize = propertyDomainSize([h w]);
    %
end

imageHandle = imagesc(searchSpace,'Parent',axesHandle);
colorbar;

% Set mouse callback
set(imageHandle,'ButtonDownFcn', ...
    @(gcbo,eventdata) mouseCallback ...
    ( ...
    gcbo, ...
    eventdata, ...
    axesHandle, ...
    searchSpace, ...
    propertyName, ...
    propertyDomain, ...
    propertyDomainSize ...
    ) ...
    );

% Hide labels
set(axesHandle,'XTick',[]);
set(axesHandle,'YTick',[]);
%%%


% Axes
set(axesHandle, ...
    'XColor', Settings.GridColor, ...
    'YColor', Settings.GridColor, ...
    'ZColor', Settings.GridColor ...
    );

% Figure
descriptionItems = cellfun ...
    ( ...
        @(pName, pDomain) {[pName ' (' num2str(length(pDomain)) '), ']}, ...
        propertyName, ...
        propertyDomain ...
    );
descriptionItems{end} = descriptionItems{end}(1:end-2);
description = [descriptionItems{:}];

set(figureHandle,'Name',['Search Space: ' description]);
set(figureHandle,'NumberTitle','off');
set(figureHandle,'Color',Settings.BackgroundColor);

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

% Define output argument if requested
if nargout == 1
    fig = figureHandle;
end

end


function mouseCallback(gcbo, eventdata, ...
    axesHandle, searchSpace, propertyName, propertyDomain, propertyDomainSize)

position = get(gca,'CurrentPoint');

[rSize cSize] = size(searchSpace);
rPosition = round(position(1,2));
cPosition = round(position(1,1));

indexArray = index2indexArray(propertyDomainSize, rSize*(cPosition-1)+rPosition);

% Assignment clicked
assignment = cellfun ...
    ( ...
        @(name, domain, index) {[name ' = ' num2str(innerValue(domain(index))) ', ']}, ...
        propertyName, ...
        propertyDomain, ...
        num2cell(indexArray) ...
    );
assignment{end} = assignment{end}(1:end-2);
assignment = [assignment{:}];

% Change title to reflect changes
title(axesHandle, ['Property values: ' assignment '; Fitness = ' num2str(searchSpace(rPosition,cPosition))]);

end


function indexArray = index2indexArray(siz,ndx)

nout = length(siz);
siz = double(siz);

if length(siz)<=nout,
  siz = [siz ones(1,nout-length(siz))];
else
  siz = [siz(1:nout-1) prod(siz(nout:end))];
end
n = length(siz);

indexArray = zeros(1,n);

k = [1 cumprod(siz(1:end-1))];
for i = n:-1:1
  vi = rem(ndx-1, k(i)) + 1;
  vj = (ndx - vi)/k(i) + 1;
  indexArray(i) = vj;
  ndx = vi;
end

end


function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
