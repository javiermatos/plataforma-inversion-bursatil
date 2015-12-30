
function [longPosition, shortPosition, noPosition, serie] = computePositionsSerie(te, set)

% var
if ~exist('set','var'); set = 'all'; end

switch lower(set)
    
    case 'all'
        serie = te.FinancialTimeSerie.Serie;
        [longPosition, shortPosition, noPosition] = te.signal2positions('index');
    
    case {'trainingset', 'training'}
        
        firstIndex = 1;
        lastIndex = te.TrainingSetItems;
        
        [longPosition, shortPosition, noPosition] = te.signal2positions('index', firstIndex, lastIndex);
        
        % Corrections
        if te.TrainingSetItems ~= 0
            serie = te.TrainingSet.Serie;
            serie = [ serie ; ones(te.TestSetItems,1)*serie(end) ];
        else
            serie = [];
        end
        
    case {'testset', 'test'}
        
        firstIndex = te.TrainingSetItems+1;
        lastIndex = te.FinancialTimeSerie.Length;
        
        [longPosition, shortPosition, noPosition] = te.signal2positions('index', firstIndex, lastIndex);
        
        % Corrections
        if te.TestSetItems ~= 0
            serie = te.TestSet.Serie;
            serie = [ ones(te.TrainingSetItems,1)*serie(1) ; serie ];
            longPosition = longPosition + firstIndex - 1;
            shortPosition = shortPosition + firstIndex - 1;
            noPosition = noPosition + firstIndex - 1;
        else
            serie = [];
        end
        
    otherwise
        error('set must be ''all'', ''training'' or ''test''.');
    
end

end
