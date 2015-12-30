
function te = initialize(fts, modeDomain, samplesDomain, riseFallThresholdDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end
if ~exist('riseFallThresholdDomain','var'); riseFallThresholdDomain = Default.RiseFallThresholdDomain; end

te = MovingAverageThreshold(fts);

te = te.exhaustiveOptimizer('Mode',modeDomain,'Samples',samplesDomain,'RiseThreshold',riseFallThresholdDomain,'FallThreshold',riseFallThresholdDomain);

end
