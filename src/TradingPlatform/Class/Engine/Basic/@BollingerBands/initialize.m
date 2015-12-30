
function te = initialize(fts, modeDomain, samplesDomain, kDomain)

if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end
if ~exist('kDomain','var'); kDomain = Default.KDomain; end

te = BollingerBands(fts);

te = te.exhaustiveOptimizer('Mode', modeDomain, 'Samples', samplesDomain, 'K', kDomain);

end
