
function te = optimum(fts, modeDomain, leadLagDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomain; end

te = MovingAveragesCrossing(fts);

te = te.exhaustiveEngine('Mode',modeDomain,'LeadLag',leadLagPairs(leadLagDomain));

end
