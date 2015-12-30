
function fitness = computeFitness(te, set)

% set
if ~exist('set','var'); set = 'training'; end

fitness = te.computeProfitLoss(set);

end
