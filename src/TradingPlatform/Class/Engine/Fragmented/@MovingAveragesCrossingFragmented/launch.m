
function te = launch(fts, mode, leadLagDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)

if ~exist('mode','var'); mode = Default.Mode; end
if ~exist('leadLagDomain','var'); leadLagDomain = Default.LeadLagDomainF; end
if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
if ~exist('jump','var'); jump = Default.Jump; end
if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
if ~exist('smoothnessFunction','var'); smoothnessFunction = Default.SmoothnessFunction; end
if ~exist('smoothnessSamples','var'); smoothnessSamples = Default.SmoothnessSamples; end

te = MovingAveragesCrossingFragmented(fts, mode, leadLagDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);

% Initialize
te = te.initialize();

end
