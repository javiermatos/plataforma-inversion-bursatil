
function te = computeParameters(te)

maxSamples = max(te.SamplesDomain);

samplesCell = cell(1,te.Fragments);
parfor i = 1:te.Fragments
    
    localEngine = te;
    
    [startIndex, endIndex] = localEngine.fragmentTrainingRange(i);
    ftsSubset = localEngine.FinancialTimeSerie.subset(startIndex-maxSamples+1, endIndex);
    
    % Training engine
    trainingEngine = MovingAverage(ftsSubset, localEngine.Mode);
    
    % Training engine will use all the serie during the learning process
    trainingEngine.Partition = 1;
    
    optimum = trainingEngine.exhaustiveProperties( ...
        'Samples', localEngine.SamplesDomain ...
        );
    
    samplesCell{i} = cell2mat(optimum);
    
end

te.Samples = smoothness(cell2array(samplesCell), te.SmoothnessFunction, te.SmoothnessSamples);

end
