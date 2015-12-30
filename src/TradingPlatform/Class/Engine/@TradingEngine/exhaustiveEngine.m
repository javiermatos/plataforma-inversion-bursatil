
function engine = exhaustiveEngine(te, varargin)

% Sort varargin to make the process faster with parfor. First those
% properties with bigger domains.
N = length(varargin);

vLength = zeros(1,N/2);
for i = 1:N/2
    vLength(i) = length(varargin{i*2});
end

[~, index] = sort(vLength,'descend');
index = index*2;

sortedVarargin = cell(size(varargin));
for i = 1:N/2
    sortedVarargin{i*2-1} = varargin{index(i)-1};
    sortedVarargin{i*2} = varargin{index(i)};
end

% Compute optimum engine in domain
optimum = te.exhaustiveOptimum(sortedVarargin{:});

engine = te;

for i = 1:length(sortedVarargin)/2
    
    engine = setfield(engine,sortedVarargin{2*i-1},optimum{1,i});
    
end

end
