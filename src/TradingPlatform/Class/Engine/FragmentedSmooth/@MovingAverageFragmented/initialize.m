
function te = initialize(fts, mode, samplesDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples)

if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomainF; end
if ~exist('mode','var'); mode = Default.Mode; end
if ~exist('fragmentSize','var'); fragmentSize = Default.FragmentSize; end
if ~exist('jump','var'); jump = Default.Jump; end
if ~exist('beginning','var'); beginningIndex = Default.BeginningIndex; end
if ~exist('smoothnessFunction','var'); smoothnessFunction = Default.SmoothnessFunction; end
if ~exist('smoothnessSamples','var'); smoothnessSamples = Default.SmoothnessSamples; end

te = MovingAverageFragmented(fts, mode, samplesDomain, fragmentSize, jump, beginningIndex, smoothnessFunction, smoothnessSamples);

% compute parameters
te = te.computeParameters();

end
