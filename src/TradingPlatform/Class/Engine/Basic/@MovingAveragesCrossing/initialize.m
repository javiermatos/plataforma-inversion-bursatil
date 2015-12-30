
function te = initialize(fts, modeDomain, leadLagDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomain; end

te = MovingAveragesCrossing(fts);

te = te.exhaustiveOptimizer('Mode',modeDomain,'LeadLag',leadLagPairs(leadLagDomain));

end
