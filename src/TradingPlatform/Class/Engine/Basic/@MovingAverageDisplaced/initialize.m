
function te = initialize(fts, modeDomain, samplesDomain, displacementDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end
if ~exist('displacementDomain','var'); displacementDomain = Default.DisplacementDomain; end

te = MovingAverageDisplaced(fts);

te = te.exhaustiveOptimizer('Mode',modeDomain,'Samples',samplesDomain,'Displacement',displacementDomain);

end
