
function fig = plotSearchSpace(algoTrader, varargin)

if isa(varargin{1},'function_handle')
    fitnessMethodWithArguments = varargin(1);
    pairs = varargin(2:end);
elseif iscell(varargin{1})
    fitnessMethodWithArguments = varargin{1};
    pairs = varargin(2:end);
else
    fitnessMethodWithArguments = {};
    pairs = varargin;
end

% There is no need to sort varargin to make it faster with parfor.
propertyName = pairs(1:2:end);
propertyDomain = pairs(2:2:end);
propertyDomainSize = cellfun(@length, pairs(2:2:end));

searchSpaceDimension = length(propertyDomainSize);

% Call optimization method
[bestIndexArray, fitnessMatrix] = exhaustive ...
    ( ...
        @(indexArray) fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray), ...
        propertyDomainSize ...
    );

% Plot fitnessMatrix
% Set figure handle
figureHandle = figure();

% Axes of the current figure
axesHandle = axes();

if searchSpaceDimension == 1
    
    plot(axesHandle, fitnessMatrix);
    
    set(axesHandle,'XTick',1:propertyDomainSize(1));
    set(axesHandle,'XTickLabel',propertyDomain{1});
    xlabel(axesHandle, ['\bf' propertyName{1}]);
    
    ylabel(axesHandle, '\bfFitness');
    
elseif searchSpaceDimension == 2
    
%     % Image
%     imagesc(flipud(fitnessMatrix'));
%     colorbar;
%     
%     set(axesHandle,'XTick',1:propertyDomainSize(1));
%     set(axesHandle,'XTickLabel',propertyDomain{1});
%     xlabel(axesHandle, ['\bf' propertyName{1}]);
%     
%     set(axesHandle,'YTick',1:propertyDomainSize(2));
%     set(axesHandle,'YTickLabel',flipud(propertyDomain{2}(:)));
%     ylabel(axesHandle, ['\bf' propertyName{2}]);
%     
%     zlabel(axesHandle, '\bfFitness');
    
    % Contour
    [cMatrix, cHandle] = contourf(axesHandle, fitnessMatrix','LineStyle','none');
    clabel(cMatrix,cHandle);
    colorbar;
    
    set(axesHandle,'XTick',1:propertyDomainSize(1));
    set(axesHandle,'XTickLabel',propertyDomain{1});
    xlabel(axesHandle, ['\bf' propertyName{1}]);
    
    set(axesHandle,'YTick',1:propertyDomainSize(2));
    set(axesHandle,'YTickLabel',propertyDomain{2});
    ylabel(axesHandle, ['\bf' propertyName{2}]);
    
    zlabel(axesHandle, '\bfFitness');
    
%     % Surface
%     surf(axesHandle, fitnessMatrix');
%     shading(axesHandle,'flat'); % 'flat', 'faceted', 'interp'
%     colorbar;
%     
%     set(axesHandle,'XTick',1:propertyDomainSize(1));
%     set(axesHandle,'XTickLabel',propertyDomain{1});
%     xlabel(axesHandle, ['\bf' propertyName{1}]);
%     
%     set(axesHandle,'YTick',1:propertyDomainSize(2));
%     set(axesHandle,'YTickLabel',propertyDomain{2});
%     ylabel(axesHandle, ['\bf' propertyName{2}]);
%     
%     zlabel(axesHandle, '\bfFitness');
    
elseif searchSpaceDimension == 3
    
    bestFitness = max(fitnessMatrix(:));
    worstFitness = min(fitnessMatrix(:));
    
    n = 5;
    v = linspace(worstFitness, bestFitness, 3*n+2);
    v = v(2:end-1);
    
    lGroup = hggroup;
    mGroup = hggroup;
    hGroup = hggroup;
    
    % Blue
    for i = 1:n
        
        pathHandle = patch(isosurface(fitnessMatrix,v(i)));
        
        % Set properties
        set(pathHandle,'FaceColor','b','EdgeColor','none','FaceAlpha',0.15);
        
        % Add plot to group
        set(pathHandle,'Parent',lGroup);
        
    end
    
    % Yellow
    for i = 1:n
        
        pathHandle = patch(isosurface(fitnessMatrix,v(i+n)));
        
        % Set properties
        set(pathHandle,'FaceColor','y','EdgeColor','none','FaceAlpha',0.30);
        
        % Add plot to group
        set(pathHandle,'Parent',mGroup);
        
    end
    
    % Red
    for i = 1:n
        
        pathHandle = patch(isosurface(fitnessMatrix,v(i+2*n)));
        
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
    
elseif searchSpaceDimension > 3
    
    % if we have more than 3 parameters we reduce them to 3 using Principal
    % Component Analysis.
    [fitnessColumn, index] = sort(fitnessMatrix(:));
    
    parameterMatrix = zeros(length(fitnessColumn),searchSpaceDimension);
    
    for i = 1:length(fitnessColumn)
        parameterMatrix(i,:) = ind2array(propertyDomainSize,index(i));
    end
    
    % Principal Component Analysis
    [r ~] = size(parameterMatrix);
    pmMean = mean(parameterMatrix);
    pmStd = std(parameterMatrix);
    standardizedParameterMatrix = (parameterMatrix - repmat(pmMean,[r 1])) ./ repmat(pmStd,[r 1]);
    [coeff ~] = eig(cov(standardizedParameterMatrix));
    reducedParameterMatrix = standardizedParameterMatrix*coeff;
    reducedParameterMatrix = reducedParameterMatrix(:,1:3);
    
%     % Plot3
%     lowEdgeColor = 'b';
%     lowFaceColor = [0 0.45 1];
%     
%     mediumEdgeColor = 'y';
%     mediumFaceColor = [1 1 0.45];
%     
%     highEdgeColor = 'r';
%     highFaceColor = [1 0.45 0.45];
%     
%     markerSize = 8;
%     
%     hold on;
%     plot3( ...
%         reducedParameterMatrix(1:floor(end*1/3),1), ...
%         reducedParameterMatrix(1:floor(end*1/3),2), ...
%         reducedParameterMatrix(1:floor(end*1/3),3), ...
%         'o', ...
%         'MarkerEdgeColor',lowEdgeColor, ...
%         'MarkerFaceColor',lowFaceColor, ...
%         'MarkerSize',markerSize ...
%         );
%     
%     plot3( ...
%         reducedParameterMatrix(ceil(end*1/3):floor(end*2/3),1), ...
%         reducedParameterMatrix(ceil(end*1/3):floor(end*2/3),2), ...
%         reducedParameterMatrix(ceil(end*1/3):floor(end*2/3),3), ...
%         'o', ...
%         'MarkerEdgeColor',mediumEdgeColor, ...
%         'MarkerFaceColor',mediumFaceColor, ...
%         'MarkerSize',markerSize ...
%         );
%     
%     plot3( ...
%         reducedParameterMatrix(ceil(end*2/3):end,1), ...
%         reducedParameterMatrix(ceil(end*2/3):end,2), ...
%         reducedParameterMatrix(ceil(end*2/3):end,3), ...
%         'o', ...
%         'MarkerEdgeColor',highEdgeColor, ...
%         'MarkerFaceColor',highFaceColor, ...
%         'MarkerSize',markerSize ...
%         );
%     hold off;
    
    % Surf
    lowEdgeColor = 'none';
    lowEdgeAlpha = 0.15;
    lowFaceColor = [0 0.45 1];
    lowFaceAlpha = 0.15;
    
    mediumEdgeColor = 'none';
    mediumEdgeAlpha = 0.3;
    mediumFaceColor = [1 1 0.45];
    mediumFaceAlpha = 0.3;
    
    highEdgeColor = 'none';
    highEdgeAlpha = 0.5;
    highFaceColor = [1 0.45 0.45];
    highFaceAlpha = 0.5;
    
    [sx sy sz] = sphere(10);
    radius = 0.15;
    sx = sx.*radius;
    sy = sy.*radius;
    sz = sz.*radius;
    
    matrixRows = size(reducedParameterMatrix,1);
    
    hold on;
    sectionIndex = 1:floor(matrixRows*1/3);
    for i = sectionIndex
        surf( ...
            sx+reducedParameterMatrix(i,1), ...
            sy+reducedParameterMatrix(i,2), ...
            sz+reducedParameterMatrix(i,3), ...
            'EdgeColor',lowEdgeColor, ...
            'EdgeAlpha',lowEdgeAlpha, ...
            'FaceColor',lowFaceColor, ...
            'FaceAlpha',lowFaceAlpha ...
            );
    end
    
    sectionIndex = ceil(matrixRows*1/3):floor(matrixRows*2/3);
    for i = sectionIndex
        surf( ...
            sx+reducedParameterMatrix(i,1), ...
            sy+reducedParameterMatrix(i,2), ...
            sz+reducedParameterMatrix(i,3), ...
            'EdgeColor',mediumEdgeColor, ...
            'EdgeAlpha',mediumEdgeAlpha, ...
            'FaceColor',mediumFaceColor, ...
            'FaceAlpha',mediumFaceAlpha ...
            );
    end
    
    sectionIndex = ceil(matrixRows*2/3):matrixRows;
    for i = sectionIndex
        surf( ...
            sx+reducedParameterMatrix(i,1), ...
            sy+reducedParameterMatrix(i,2), ...
            sz+reducedParameterMatrix(i,3), ...
            'EdgeColor',highEdgeColor, ...
            'EdgeAlpha',highEdgeAlpha, ...
            'FaceColor',highFaceColor, ...
            'FaceAlpha',highFaceAlpha ...
            );
    end
    hold off;
    
    axis square;
    
    % Labels
    xlabel(axesHandle, '\bfPCAx');
    ylabel(axesHandle, '\bfPCAy');
    zlabel(axesHandle, '\bfPCAz');
    
end


% Axes
optimumItems = cellfun ...
    ( ...
        @(pName, pDomain, pIndex) {[pName ' = ' num2str(innerValue(pDomain(pIndex))) ', ']}, ...
        propertyName, ...
        propertyDomain, ...
        num2cell(bestIndexArray) ...
    );
optimumItems{end} = optimumItems{end}(1:end-2);
optimum = [optimumItems{:}];

% Get best fitness value
cBestIndexArray = num2cell(bestIndexArray);
bestFitness = fitnessMatrix(cBestIndexArray{:});

title(axesHandle, ['\bfOptimum: ' optimum ' (Fitness = ' num2str(bestFitness) ')']);
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

function indexArray = ind2array(domainSize, n)

% Initial correction
n = n-1;

N = length(domainSize);
indexArray = zeros(1, N);
for i = N:-1:1
    
    baseValue = prod(domainSize(1:i-1));
    
    idiv = floor(n/baseValue);
    n = n - idiv*baseValue;
    
    indexArray(i) = idiv;
    
end

% Final correction
indexArray = indexArray+1;

end

function value = innerValue(valueOrCellValue)

if ~iscell(valueOrCellValue)
    value = valueOrCellValue;
else
    value = valueOrCellValue{1};
end

end
