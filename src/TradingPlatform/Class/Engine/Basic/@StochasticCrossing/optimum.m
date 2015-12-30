
function te = optimum(fts, stochasticSamplesDomain, highThresholdDomain, lowThresholdDomain, modeDomain, movingAverageSamplesDomain)

if ~exist('stochasticSamplesDomain','var'); stochasticSamplesDomain = Default.SamplesDomain; end
if ~exist('highThresholdDomain','var'); highThresholdDomain = Default.HighThresholdDomain; end
if ~exist('lowThresholdDomain','var'); lowThresholdDomain = Default.LowThresholdDomain; end
if ~exist('modeDomain','var'); modeDomain = Default.ModeDomain; end
if ~exist('movingAverageSamplesDomain','var'); movingAverageSamplesDomain = Default.SamplesDomain; end

te = StochasticCrossing(fts);

te = te.exhaustiveEngine( ...
    'StochasticSamples', stochasticSamplesDomain, ...
    'HighThreshold', highThresholdDomain, ...
    'LowThreshold', lowThresholdDomain, ...
    'Mode', modeDomain, ...
    'MovingAverageSamples', movingAverageSamplesDomain ...
    );

end
