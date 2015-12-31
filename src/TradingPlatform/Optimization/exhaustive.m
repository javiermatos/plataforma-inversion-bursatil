
function [bestIndexArray, searchSpace] = exhaustive(selectionFunction, fitnessFunction, searchSpaceSize)

if length(searchSpaceSize) == 1
    searchSpace = zeros(searchSpaceSize,1);
else
    searchSpace = zeros(searchSpaceSize);
end

parfor i = 1:prod(searchSpaceSize)
    
    indexArray = index2indexArray(searchSpaceSize,i);
    
    searchSpace(i) = feval(fitnessFunction,indexArray);
    
end

% Get first best value
[~, index] = selectionFunction(searchSpace(:));
bestIndexArray = index2indexArray(searchSpaceSize,index);

% % Get all best values
% index = find(searchSpace(:) == selectionFunction(searchSpace(:))); 
% bestIndexArray = index2indexArray(searchSpaceSize,index(1));

end


function indexArray = index2indexArray(searchSpaceSize, n)

% Initial correction
n = n-1;

base = cumprod([1 searchSpaceSize(1:end-1)]);

N = length(searchSpaceSize);

indexArray = zeros(1, N);

for i = N:-1:1
    
    idiv = floor(n/base(i));
    n = n - idiv*base(i);
    
    indexArray(i) = idiv;
    
end

% Final correction
indexArray = indexArray+1;

end
