
function fitness = exhaustiveFitness(te, varargin)

property = varargin{1};
domain = varargin{2};
N = length(domain);


if length(varargin) == 2
    % Base case
    
    fitness = zeros(1,N);
    
    parfor i = 1:N
        
        tempEngine = te;
        
        if iscell(domain)
            value = domain{i};
        else
            value = domain(i);
        end
        
        tempEngine = subsasgn(tempEngine,struct('type','.','subs',property),value);
        
        fitness(i) = tempEngine.Fitness;
        
    end
    
else
    % General case
    
    fitnessSubset = cell(1,N);
    parfor i = 1:N
        
        tempEngine = te;
        
        if iscell(domain)
            value = domain{i};
        else
            value = domain(i);
        end
        
        tempEngine = subsasgn(tempEngine,struct('type','.','subs',property),value);
        
        fitnessSubset{i} = exhaustiveFitness(tempEngine, varargin{3:end});
        
    end
    
    V = length(varargin);
    
    % lengthVector
    lengthVector = zeros(1, V/2);
    lengthVector(1) = N;
    for i = 2:V/2
        lengthVector(i) = length(varargin{i*2});
    end
    
    % subs
    subs = cell(1,V/2);
    for i = 1:V/2
        subs{i} = ':';
    end
    
    selection.type = '()';
    selection.subs = subs;
    
    fitness = zeros(lengthVector);
    for i = 1:N
        
        selection.subs{1} = i;
        fitness = subsasgn(fitness, selection, fitnessSubset{i});
        
    end
    
    
end

end
