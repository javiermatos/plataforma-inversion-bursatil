
function fig = plotSearchSpace123(algoTrader, varargin)

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

% Error if there are more parameters than allowed
if length(outerPairs) > 6
    error('Error: at most 3 parameters can be represented');
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

if searchSpaceDimension == 1
    
    % Curve
    plot(axesHandle, searchSpace);
    
    % Labels
    set(axesHandle,'XTick',1:propertyDomainSize(1));
    set(axesHandle,'XTickLabel',propertyDomain{1});
    xlabel(axesHandle, ['\bf' propertyName{1}]);
    
    ylabel(axesHandle, '\bfFitness');
    
    % Axes limit
    maxFitness = max(searchSpace(:));
    minFitness = min(searchSpace(:));
    diffFitness = maxFitness - minFitness;
    s = 0.1;
    
    ymin = minFitness-(s*diffFitness);
    ymax = maxFitness+(s*diffFitness);
    
    axis(axesHandle, [1 propertyDomainSize(1) ymin ymax]);
    
elseif searchSpaceDimension == 2
    
    % Sort dimensions to provide a better representation
    [~, index] = sort(propertyDomainSize, 'ascend');
    
    propertyName = propertyName(index);
    propertyDomain = propertyDomain(index);
    propertyDomainSize = propertyDomainSize(index);
    
    searchSpace = permute(searchSpace, index);
    %
    
    % Image
    imagesc(searchSpace);
    colorbar;
    
    % Labels
    set(axesHandle,'XTick',1:propertyDomainSize(2));
    set(axesHandle,'XTickLabel',propertyDomain{2});
    xlabel(axesHandle, ['\bf' propertyName{2}]);
    
    set(axesHandle,'YTick',1:propertyDomainSize(1));
    set(axesHandle,'YTickLabel',propertyDomain{1});
    ylabel(axesHandle, ['\bf' propertyName{1}]);
    
%     % Contour
%     [cMatrix, cHandle] = contourf(axesHandle,searchSpace,'LineStyle','none');
%     clabel(cMatrix,cHandle);
%     colorbar;
%     
%     % Labels
%     set(axesHandle,'XTick',1:propertyDomainSize(2));
%     set(axesHandle,'XTickLabel',propertyDomain{2});
%     xlabel(axesHandle, ['\bf' propertyName{2}]);
%     
%     set(axesHandle,'YTick',1:propertyDomainSize(1));
%     set(axesHandle,'YTickLabel',propertyDomain{1});
%     ylabel(axesHandle, ['\bf' propertyName{1}]);
    
%     % Surface
%     surf(axesHandle, searchSpace);
%     shading(axesHandle,'flat'); % 'flat', 'faceted', 'interp'
%     colorbar;
%     
%     % Labels
%     set(axesHandle,'XTick',1:propertyDomainSize(2));
%     set(axesHandle,'XTickLabel',propertyDomain{2});
%     xlabel(axesHandle, ['\bf' propertyName{2}]);
%     
%     set(axesHandle,'YTick',1:propertyDomainSize(1));
%     set(axesHandle,'YTickLabel',propertyDomain{1});
%     ylabel(axesHandle, ['\bf' propertyName{1}]);
%     
%     zlabel(axesHandle, '\bfFitness');
    
    % Axes limit
    axis(axesHandle, [1 propertyDomainSize(2) 1 propertyDomainSize(1)]);
    
elseif searchSpaceDimension == 3
    
    % Sort dimensions to provide a better representation
    [~, index] = sort(propertyDomainSize, 'descend');
    
    propertyName = propertyName(index);
    propertyDomain = propertyDomain(index);
    propertyDomainSize = propertyDomainSize(index);
    
    searchSpace = permute(searchSpace, index);
    %
    
    maxFitness = max(searchSpace(:));
    minFitness = min(searchSpace(:));
    
    n = 5;
    v = linspace(minFitness, maxFitness, 3*n+2);
    v = v(2:end-1);
    
    lGroup = hggroup;
    mGroup = hggroup;
    hGroup = hggroup;
    
    % Blue
    for i = 1:n
        
        pathHandle = patch(isosurface(searchSpace,v(i)));
        
        % Set properties
        set(pathHandle,'FaceColor','b','EdgeColor','none','FaceAlpha',0.15);
        
        % Add plot to group
        set(pathHandle,'Parent',lGroup);
        
    end
    
    % Yellow
    for i = 1:n
        
        pathHandle = patch(isosurface(searchSpace,v(i+n)));
        
        % Set properties
        set(pathHandle,'FaceColor','y','EdgeColor','none','FaceAlpha',0.30);
        
        % Add plot to group
        set(pathHandle,'Parent',mGroup);
        
    end
    
    % Red
    for i = 1:n
        
        pathHandle = patch(isosurface(searchSpace,v(i+2*n)));
        
        % Set properties
        set(pathHandle,'FaceColor','r','EdgeColor','none','FaceAlpha',0.5);
        
        % Add plot to group
        set(pathHandle,'Parent',hGroup);
        
    end
    
    % Labels
    set(axesHandle,'YTick',1:propertyDomainSize(1));
    set(axesHandle,'YTickLabel',propertyDomain{1});
    ylabel(axesHandle, ['\bf' propertyName{1}]);
    
    set(axesHandle,'XTick',1:propertyDomainSize(2));
    set(axesHandle,'XTickLabel',propertyDomain{2});
    xlabel(axesHandle, ['\bf' propertyName{2}]);
    
    set(axesHandle,'ZTick',1:propertyDomainSize(3));
    set(axesHandle,'ZTickLabel',propertyDomain{3});
    zlabel(axesHandle, ['\bf' propertyName{3}]);
    
    % Axes limit
    axis(axesHandle, [1 propertyDomainSize(2) 1 propertyDomainSize(1) 1 propertyDomainSize(3)]);

end


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
