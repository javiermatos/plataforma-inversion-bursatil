
function [bestIndexArray, fitnessMatrix] = exhaustiveSecuential(fitnessFunction, domainSize)

if length(domainSize) == 1
    fitnessMatrix = zeros(domainSize,1);
else
    fitnessMatrix = zeros(domainSize);
end

for i = 1:prod(domainSize)
    
    indexArray = ind2array(domainSize,i);
    
    fitnessMatrix(i) = feval(fitnessFunction,indexArray);
    
end

% Get first max value
[~, index] = max(fitnessMatrix(:));
bestIndexArray = index2indexArray(domainSize,index);

% % Get all max values
% index = find(fitnessMatrix(:) == max(fitnessMatrix(:))); 
% bestIndexArray = index2indexArray(domainSize,index(1));

end

function indexArray = index2indexArray(domainSize, n)

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

% function bestIndexArray = exhaustiveSecuential(fitnessFunction, domainSize)
% 
% bestFitness = 0;
% bestIndexArray = ones(1, length(domainSize));
% 
% for i = 1:prod(domainSize)
%     
%     indexArray = ind2array(domainSize, i);
%     fitness = fitnessFunction(indexArray);
%     
%     if fitness > bestFitness
%         bestFitness = fitness;
%         bestIndexArray = indexArray;
%     end
%     
% end
% 
% end
% 
% function indexArray = ind2array(domainSize, n)
% 
% % Initial correction
% n = n-1;
% 
% N = length(domainSize);
% indexArray = zeros(1, N);
% for i = 1:N
%     
%     baseValue = prod(domainSize(i+1:N));
%     
%     idiv = floor(n/baseValue);
%     n = n - idiv*baseValue;
%     
%     indexArray(i) = idiv;
%     
% end
% 
% % Final correction
% indexArray = indexArray+1;
% 
% end
