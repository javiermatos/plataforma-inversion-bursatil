
function [optimum, fitness] = exhaustiveOptimum(te, varargin)

fitness = exhaustiveFitness(te, varargin{:});
fitnessColumn = fitness(:);

optimumIndex = find(fitnessColumn==max(fitnessColumn));

O = length(optimumIndex);
V = length(varargin);

% lengthVector
lengthVector = zeros(1,V/2);
for i = 1:V/2
    lengthVector(i) = length(varargin{i*2});
end

optimum = cell(O,V/2);

for i = 1:O
    
    index = optimumIndex(i)-1;
    
    for j = (V/2):-1:1
        
        subsetSize = prod(lengthVector(1:j-1));
        subIndex = floor(index/subsetSize);
        
        if iscell(varargin{j*2})
            value = varargin{j*2}{subIndex+1};
        else
            value = varargin{j*2}(subIndex+1);
        end
        
        optimum{i,j} = value;
        %optimum{i,j} = subIndex+1;
        
        index = index-(subIndex*subsetSize);
        
    end
    
end

end
