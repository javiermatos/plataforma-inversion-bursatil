
function te = computeParameters(te)

maxSamples = max(te.SamplesDomain);

samplesCell = cell(1, te.Fragments);
riseThresholdCell = cell(1, te.Fragments);
fallThresholdCell = cell(1, te.Fragments);
parfor i = 1:te.Fragments
    
    localEngine = te;
    
    [ startIndex endIndex ] = localEngine.fragmentTrainingRange(i);
    %ftsSubset = localEngine.FinancialTimeSerie.subset(startIndex-localEngine.Samples(i)+1, endIndex);
    ftsSubset = localEngine.FinancialTimeSerie.subset(startIndex-maxSamples+1, endIndex);
    
    % Training engine
    trainingEngine = MovingAverageThreshold(ftsSubset);
    
    % Training engine will use all the serie during the learning process
    trainingEngine.Partition = 1;
    
    optimum = trainingEngine.exhaustiveProperties( ...
        'Samples',te.SamplesDomain, ...
        'RiseThreshold',te.RiseFallThresholdDomain, ...
        'FallThreshold',te.RiseFallThresholdDomain ...
        );
    
    samplesCell{i} = cell2mat(optimum(:,1));
    riseThresholdCell{i} = cell2mat(optimum(:,2));
    fallThresholdCell{i} = cell2mat(optimum(:,3));
    
end

te.Samples = smoothness(cell2array(samplesCell), te.SmoothnessFunction, te.SmoothnessSamples);
te.RiseThreshold = smoothness(cell2array(riseThresholdCell), te.SmoothnessFunction, te.SmoothnessSamples);
te.FallThreshold = smoothness(cell2array(fallThresholdCell), te.SmoothnessFunction, te.SmoothnessSamples);

end
