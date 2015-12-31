
function bestIndexArray = randomSearch(selectionFunction, fitnessFunction, searchSpaceSize, iterations)

% Default number of iterations
if ~exist('iterations','var'); iterations = 500; end;

% Apply selection function
if strcmp(func2str(@max),func2str(selectionFunction))
    objectiveMaximize = true;
    bestFitness = -Inf;
else
    objectiveMaximize = false;
    bestFitness = Inf;
end

bestIndexArray = [];

% Main loop
for i = 1:iterations
    
    indexArray = ones(1, length(searchSpaceSize))+round(rand(1,length(searchSpaceSize)).*(searchSpaceSize-1));
    
    currentFitness = fitnessFunction(indexArray);
    
    if objectiveMaximize && bestFitness < currentFitness
        
        bestIndexArray = indexArray;
        bestFitness = currentFitness;
        
    elseif ~objectiveMaximize && bestFitness > currentFitness
        
        bestIndexArray = indexArray;
        bestFitness = currentFitness;
        
    end
    
end

end
