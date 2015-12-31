
function fig = plotSearchSpace123(algoTrader, varargin)

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

% Error if there are more parameters than allowed
if length(pairs) > 6
    error('Error: at most 3 parameters can be represented');
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
    
    % Axes limit
    axis(axesHandle, [1 propertyDomainSize(1) ymin ymax]);
    
elseif searchSpaceDimension == 2
    
    % Sort dimensions to provide a better representation
    [~, index] = sort(propertyDomainSize, 'ascend');
    
    propertyName = propertyName(index);
    propertyDomain = propertyDomain(index);
    propertyDomainSize = propertyDomainSize(index);
    
    searchSpace = permute(searchSpace, index);
    %
    
%     % Image
%     imagesc(searchSpace);
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
    
    % Surface
    surf(axesHandle, searchSpace);
    shading(axesHandle,'flat'); % 'flat', 'faceted', 'interp'
    
    %colorbar;
    
    % Labels
    set(axesHandle,'XTick',1:propertyDomainSize(2));
    set(axesHandle,'XTickLabel',propertyDomain{2});
    xlabel(axesHandle, ['\bf' propertyName{2}]);
    
    set(axesHandle,'YTick',1:propertyDomainSize(1));
    set(axesHandle,'YTickLabel',propertyDomain{1});
    ylabel(axesHandle, ['\bf' propertyName{1}]);
    
    zlabel(axesHandle, '\bfFitness');
    
    % Axes limit
    axis(axesHandle, [1 propertyDomainSize(2) 1 propertyDomainSize(1)]);
    
elseif searchSpaceDimension == 3
    
    % Sort dimensions to provide a better representation
    [~, index] = sort(propertyDomainSize, 'descend');
    
    propertyName = propertyName(index);
    propertyDomain = propertyDomain(index);
    propertyDomainSize = propertyDomainSize(index);
    
    % Search space
    searchSpace = permute(searchSpace, index);
    
    % Min and max values
    maxFitness = max(searchSpace(:));
    minFitness = min(searchSpace(:));
    
    % Patches
    patches = 100;
    
    % Values and its scale
    logvector = fliplr((1-log(linspace(1,exp(1),patches))).^1.25);
    value = (logvector*(maxFitness-minFitness))+minFitness;
    
    % Colormap
    cmap = colormap('jet');
    color = cmap(round(logvector*(length(cmap)-1)+1),:);
    colormap(color);
    
    % Draw patches
    for i = 1:patches
        ph = patch(isosurface(searchSpace,value(i)));
        %isosurface(searchSpace,value(i));
        
        % Set properties
        set(ph,'FaceColor',color(i,:),'EdgeColor','none');
        set(ph,'FaceAlpha',logvector(i)^5);
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
    
    % Colorbar limits
    set(axesHandle, 'CLim', [minFitness maxFitness]);

end


% Axes
set(axesHandle, ...
    'XColor', Default.GridColor, ...
    'YColor', Default.GridColor, ...
    'ZColor', Default.GridColor ...
    );

% set(axesHandle,'GridLineStyle', 'none');
% set(axesHandle,'Box', Default.Box);

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
