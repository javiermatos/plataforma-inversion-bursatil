
function te = initialize(fts, mode, leadLagDomain, riseFallThresholdDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)

if ~exist('mode','var'); mode = Default.Mode; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomainF; end
if ~exist('riseFallThresholdDomain','var'); riseFallThresholdDomain = Default.RiseFallThresholdDomainF; end
if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
if ~exist('jump','var'); jump = Default.Jump; end
if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
if ~exist('smoothnessFunction','var'); smoothnessFunction = Default.SmoothnessFunction; end
if ~exist('smoothnessSamples','var'); smoothnessSamples = Default.SmoothnessSamples; end

te = MovingAveragesCrossingThresholdFragmented(fts, mode, leadLagDomain, riseFallThresholdDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);

% Initialize
te = te.computeParameters();

end
