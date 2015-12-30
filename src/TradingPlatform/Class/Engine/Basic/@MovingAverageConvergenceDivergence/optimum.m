
function te = optimum(fts, modeDomain, leadLagDomain, samplesDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end

te = MovingAverageConvergenceDivergence(fts);

te = te.exhaustiveEngine('Mode', modeDomain, 'LeadLag', leadLagPairs(leadLagDomain), 'Samples', samplesDomain);

end
