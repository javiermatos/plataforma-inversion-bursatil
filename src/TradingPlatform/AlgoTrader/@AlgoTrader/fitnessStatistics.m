
function [minFitness, maxFitness, meanFitness, stdFitness] ...
    = fitnessStatistics(algoTrader, varargin)

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

% Call optimization method
[~, searchSpace] = exhaustive ...
    ( ...
        @max, ...
        @(indexArray) fitnessFunctionWrapper(algoTrader, fitnessMethodWithArguments, propertyName, propertyDomain, indexArray), ...
        propertyDomainSize ...
    );

fitness = searchSpace(:);

minFitness = min(fitness);
maxFitness = max(fitness);
meanFitness = sum(fitness)/length(fitness);
stdFitness = sqrt(sum((fitness-meanFitness).^2)/length(fitness));
%meanFitness = mean(fitness);
%stdFitness = std(fitness,1);


% Figure
figureHandle = figure;
axesHandle = axes();

% Basic
descriptionItems = cellfun ...
    ( ...
        @(pName, pDomain) {[pName ' (' num2str(length(pDomain)) '), ']}, ...
        propertyName, ...
        propertyDomain ...
    );
descriptionItems{end} = descriptionItems{end}(1:end-2);
description = [descriptionItems{:}];

set(figureHandle,'Name',['Fitness function: ' description]);
set(figureHandle,'NumberTitle','off');
set(figureHandle,'Color',Default.BackgroundColor);

% Histogram
[n,xout] = hist(fitness, 100);
barh(axesHandle,xout,n,'FaceColor',[255 42 127]/255,'EdgeColor',[128 0 51]/255,'BarWidth',1);

% Information and fixes
xlabel(axesHandle, '\bfNumber of instances');
ylabel(axesHandle, '\bfFitness');

% Axes boxes
set(axesHandle, 'Box', Default.Box);

% Axes color
set(axesHandle, ...
    'XColor', Default.GridColor, ...
    'YColor', Default.GridColor, ...
    'ZColor', Default.GridColor ...
    );

prettySize(figureHandle);

% Protects against edition if needed
set(figureHandle,'HandleVisibility','callback');

end
