
function te = initialize(fts, modeDomain, samplesDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end

te = MovingAverage(fts);

te = te.exhaustiveOptimizer('Mode',modeDomain,'Samples',samplesDomain);

end
