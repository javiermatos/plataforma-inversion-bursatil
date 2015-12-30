
function fitness = computeFitness(tef, set)

% set
if ~exist('set','var'); set = 'test'; end

fitness = tef.computeProfitLoss(set);

end
