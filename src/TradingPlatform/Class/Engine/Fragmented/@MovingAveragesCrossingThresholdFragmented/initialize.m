
function te = initialize(te)

maxLeadLagg = max(te.LeadLagDomain);

leadCell = cell(1, te.Fragments);
lagCell = cell(1, te.Fragments);
riseThresholdCell = cell(1, te.Fragments);
fallThresholdCell = cell(1, te.Fragments);
parfor i = 1:te.Fragments
    
    localEngine = te;
    
    [startIndex, endIndex] = localEngine.fragmentRange(i);
    ftsSubset = localEngine.FinancialTimeSerie.subset(startIndex-maxLeadLagg+1, endIndex);
    
    % Training engine
    trainingEngine = MovingAveragesCrossingThreshold(ftsSubset);
    
    % Training engine will use all the serie during the learning process
    trainingEngine.Partition = 1;
    
    % Compute optimum
    optimum = trainingEngine.exhaustiveOptimum( ...
        'LeadLag',leadLagPairs(localEngine.LeadLagDomain), ...
        'RiseThreshold',te.RiseFallThresholdDomain, ...
        'FallThreshold',te.RiseFallThresholdDomain ...
        );
    
    temp = cell2mat(optimum(:,1));
    leadCell{i} = temp(:,1);
    lagCell{i} = temp(:,2);
    riseThresholdCell{i} = cell2mat(optimum(:,2));
    fallThresholdCell{i} = cell2mat(optimum(:,3));
    
end

te.Lead = round(smoothness(cell2array(leadCell), te.SmoothnessFunction, te.SmoothnessSamples));
te.Lag = round(smoothness(cell2array(lagCell), te.SmoothnessFunction, te.SmoothnessSamples));
te.RiseThreshold = smoothness(cell2array(riseThresholdCell), te.SmoothnessFunction, te.SmoothnessSamples);
te.FallThreshold = smoothness(cell2array(fallThresholdCell), te.SmoothnessFunction, te.SmoothnessSamples);

end
