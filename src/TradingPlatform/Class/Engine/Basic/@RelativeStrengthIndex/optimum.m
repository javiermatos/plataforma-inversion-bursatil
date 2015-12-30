
function te = optimum(fts, samplesDomain, highThresholdDomain, lowThresholdDomain)

if ~exist('samplesDomain','var'); samplesDomain = Default.SamplesDomain; end
if ~exist('highThresholdDomain','var'); highThresholdDomain = Default.HighThresholdDomain; end
if ~exist('lowThresholdDomain','var'); lowThresholdDomain = Default.LowThresholdDomain; end

te = RelativeStrengthIndex(fts);

te = te.exhaustiveEngine('Samples', samplesDomain, 'HighThreshold', highThresholdDomain, 'LowThreshold', lowThresholdDomain);

end
