
function te = initialize(fts, modeDomain, leadLagDomain, samplesDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end

te = MovingAverageConvergenceDivergence(fts);

te = te.exhaustiveOptimizer('Mode', modeDomain, 'LeadLag', leadLagPairs(leadLagDomain), 'Samples', samplesDomain);

end
