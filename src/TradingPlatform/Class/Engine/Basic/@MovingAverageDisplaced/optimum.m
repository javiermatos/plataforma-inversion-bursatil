
function te = optimum(fts, modeDomain, samplesDomain, displacementDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end
if ~exist('displacementDomain','var'); displacementDomain = Default.DisplacementDomain; end

te = MovingAverageDisplaced(fts);

te = te.exhaustiveEngine('Mode',modeDomain,'Samples',samplesDomain,'Displacement',displacementDomain);

end
