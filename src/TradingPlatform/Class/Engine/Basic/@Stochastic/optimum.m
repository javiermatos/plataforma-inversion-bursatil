
function te = optimum(fts, stochasticSamplesDomain, highThresholdDomain, lowThresholdDomain)

if ~exist('stochasticSamplesDomain','var'); stochasticSamplesDomain = Default.SamplesDomain; end
if ~exist('highThresholdDomain','var'); highThresholdDomain = Default.HighThresholdDomain; end
if ~exist('lowThresholdDomain','var'); lowThresholdDomain = Default.LowThresholdDomain; end

te = Stochastic(fts);

te = te.exhaustiveEngine('StochasticSamples', stochasticSamplesDomain, 'HighThreshold', highThresholdDomain, 'LowThreshold', lowThresholdDomain);

end
