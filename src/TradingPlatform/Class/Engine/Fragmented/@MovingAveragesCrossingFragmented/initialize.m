
function te = initialize(te)

maxLeadLag = max(te.LeadLagDomain);

leadCell = cell(1, te.Fragments);
lagCell = cell(1, te.Fragments);
parfor i = 1:te.Fragments
    
    localEngine = te;
    
    [startIndex, endIndex] = localEngine.fragmentRange(i);
    ftsSubset = localEngine.FinancialTimeSerie.subset(startIndex-maxLeadLag+1, endIndex);
    
    %Training engine
    trainingEngine = MovingAveragesCrossing(ftsSubset);
    
    % Training engine will use all the in put data as learning set
    trainingEngine.Partition = 1;
    
    % Compute optimum
    optimum = trainingEngine.exhaustiveOptimum( ...
        'LeadLag',leadLagPairs(localEngine.LeadLagDomain) ...
        );
    
    temp = cell2mat(optimum);
    leadCell{i} = temp(:,1);
    lagCell{i} = temp(:,2);
    
end

te.Lead = round(smoothness(cell2array(leadCell), te.SmoothnessFunction, te.SmoothnessSamples));
te.Lag = round(smoothness(cell2array(lagCell), te.SmoothnessFunction, te.SmoothnessSamples));

end
