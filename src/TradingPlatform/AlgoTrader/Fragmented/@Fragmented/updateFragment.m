
function updateFragment(algoTrader, src, event)

if isempty(algoTrader.Fragment);
    
    dataSerieLength = algoTrader.DataSerie.Length;
    trainingSetSize = algoTrader.TrainingSetSize;
    testSetSize = algoTrader.TestSetSize;
    
    % Error if DataSerie is not long enough
    if dataSerieLength<trainingSetSize+testSetSize
        error('Error: DataSerie is not long enough');
    end
    
    % Number of fragments
    nFragments = ceil((dataSerieLength-trainingSetSize)/testSetSize);
    
    % Allocate space
    algoTrader.Fragment = algoTrader.InnerAlgoTrader.empty(0, nFragments);
    
    for i = 1:nFragments
         
        algoTrader.Fragment(i) = algoTrader.InnerAlgoTrader.clone();
        
        % Reference index from which others are calculated
        referenceIndex = testSetSize*(i-1)+1;
        
        % Set fragment training set
        algoTrader.Fragment(i).TrainingSet = [referenceIndex referenceIndex+trainingSetSize-1];
        
        % Set fragment test set
        algoTrader.Fragment(i).TestSet = [referenceIndex+trainingSetSize min(referenceIndex+trainingSetSize+testSetSize-1, dataSerieLength)];
        
    end
    
end

end
