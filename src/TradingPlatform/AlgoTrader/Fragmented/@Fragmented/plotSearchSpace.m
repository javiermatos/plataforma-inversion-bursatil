
function fig = plotSearchSpace(algoTrader, varargin)

% Default fitness function is built-in fitness which calls profitLoss
fitnessMethodWithArguments = {};

% Default selection function is max
selectionFunction = @max;

% Optimization method is exhaustive
optimizationMethod = @exhaustive;

% Change default if requested in the call
if length(varargin) >= 3
    
    if isa(varargin{1},'function_handle')
        fitnessMethodWithArguments = varargin(1);
    elseif iscell(varargin{1})
        fitnessMethodWithArguments = varargin{1};
    end
    
    selectionFunction = varargin{2};
    
    outerPairs = varargin{3};
    innerPairs = varargin{4};
    
else
    
    outerPairs = varargin{1};
    innerPairs = varargin{2};
    
end

%
optimizationSpecs = {};
if ~isempty(fitnessMethodWithArguments)
    optimizationSpecs = {fitnessMethodWithArguments selectionFunction optimizationMethod};
end

% Organize input
outerPropertyName = outerPairs(1:2:end);
outerPropertyDomain = outerPairs(2:2:end);
outerPropertyDomainSize = cellfun(@length, outerPropertyDomain);

% Allocate to store search space
if length(outerPropertyDomainSize) == 1
    searchSpace = zeros(outerPropertyDomainSize,1);
else
    searchSpace = zeros(outerPropertyDomainSize);
end

% Optimize
for i = 1:prod(outerPropertyDomainSize)
    
    % Create a local copy to manipulate
    localAlgoTrader = algoTrader.clone();
    
    % Indexes for outer values
    indexArray = index2indexArray(outerPropertyDomainSize,i);
    
    % Assign
    for j = 1:length(outerPropertyName)
        
        subsasgn( ...
            localAlgoTrader, ...
            struct( ...
                'type','.', ...
                'subs',outerPropertyName{j} ...
                ),...
            innerValue(outerPropertyDomain{j}(indexArray(j))) ...
            );
        
    end
    
    % Call optimization method
    localAlgoTrader.optimize( ...
        optimizationSpecs{:}, ...
        {}, innerPairs ...
        );
    
    % Postfix
    searchSpace = subsasgn( ...
        searchSpace, ...
        substruct('()',num2cell(indexArray)), ...
        localAlgoTrader.fitness(fitnessMethodWithArguments{:}) ...
        );
    
end

% Conversion
propertyName = outerPropertyName;
propertyDomain = outerPropertyDomain;
propertyDomainSize = outerPropertyDomainSize;

%
searchSpaceDimension = length(propertyName);

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
    'XColor', Default.GridColor, ...
    'YColor', Default.GridColor, ...
    'ZColor', Default.GridColor ...
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
set(figureHandle,'Color',Default.BackgroundColor);

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
title(axesHandle, ['\bfProperty values: ' assignment '; Fitness = ' num2str(searchSpace(rPosition,cPosition))]);

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
