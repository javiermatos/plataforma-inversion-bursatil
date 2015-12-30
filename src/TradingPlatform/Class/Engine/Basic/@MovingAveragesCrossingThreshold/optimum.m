
function te = optimum(fts, modeDomain, leadLagDomain, riseFallThresholdDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomain; end
if ~exist('riseFallThresholdDomain','var'); riseFallThresholdDomain = Default.RiseFallThresholdDomain; end

te = MovingAveragesCrossingThreshold(fts);

% Full
te = te.exhaustiveEngine('Mode',modeDomain,'LeadLag',leadLagPairs(leadLagDomain),'RiseThreshold',riseFallThresholdDomain,'FallThreshold',riseFallThresholdDomain);

end
