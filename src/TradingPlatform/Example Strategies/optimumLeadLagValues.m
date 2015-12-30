
% Optimum lead/lag values
function [leading, lagging, fitness] = optimumLeadLagValues(stockQuotes, offset, requiredValues, optionalValues)

requiredValues = reshape(requiredValues,[],1);

if exist('optionalValues','var')
    
    % Error conditions
    % if offset>length(stockQuotes)
    %     error('length(stockQuotes) must be greather than offset.');
    % end
    %
    % if max(lagValues)>offset
    %     error('offset must be greather than max(lagValues).');
    % end
    
    optionalValues = reshape(optionalValues,[],1);
    
    [leading, lagging, fitness] = optimumLeadLagValues2(stockQuotes, offset, requiredValues, optionalValues);
else
    
    % Error conditions
    % if offset>length(stockQuotes)
    %     error('length(stockQuotes) must be greather than offset.');
    % end
    %
    % if max(requiredValues)>offset
    %     error('offset must be greather than max(values).');
    % end
    %
    % if ~issorted(requiredValues)
    %     error('range argument must be sorted in ascending order.');
    % end
    
    [leading, lagging, fitness] = optimumLeadLagValues1(stockQuotes, offset, requiredValues);
end

end

% Optimum lead/lag values (one argument for leading and lagging)
function [leading, lagging, fitness] = optimumLeadLagValues1(stockQuotes, offset, values)

N = length(values);

fitness = zeros(N-1,N);

% i represents lead value to calculate moving average. If i goes from 1 to
% N then the last row of the fitness table will hace only zero values.
parfor i = 1:N-1
    
    % fitness table is filled in rows. It is needed to do this in order to
    % allow parfor loop.
    rowFitness = zeros(1,N);
    
    % j represents lag value to calculate moving average
    for j = i+1:N
        
        signal = leadLagMovAvg(stockQuotes,values(i),values(j));
        signal(1:offset) = 0;
        
        rowFitness(j) = profitLoss(stockQuotes,signal);
        
    end
    
    % Display iteration
    % disp(num2str(values(i)));
    
    % Store row in fitness table
    fitness(i,:) = rowFitness;
    
end

% Get values that give the higher return
[leadIndex, lagIndex] = find(fitness == max(max(fitness)));
leading = values(leadIndex);
lagging = values(lagIndex);

%profitLossSerie(stockQuotes, leadLagMovAvg(stockQuotes, leading, lagging));

end

% Optimum lead/lag values (two arguments for leading and lagging)
function [leading, lagging, fitness] = optimumLeadLagValues2(stockQuotes, offset, leadValues, lagValues)

N = length(leadValues);
M = length(lagValues);

fitness = zeros(N,M);

% i represents lead value to calculate moving average. If i goes from 1 to
% N then the last row of the fitness table will hace only zero values.
parfor i = 1:N
    
    % fitness table is filled in rows. It is needed to do this in order to
    % allow parfor loop.
    rowFitness = zeros(1,M);
    
    % j represents lag value to calculate moving average
    for j = 1:M
        
        signal = leadLagMovAvg(stockQuotes,leadValues(i),lagValues(j));
        signal(1:offset) = 0;
        
        rowFitness(j) = profitLoss(stockQuotes,signal);
        
    end
    
    % Display iteration
    % disp(num2str(i));
    
    % Store row in fitness table
    fitness(i,:) = rowFitness;
    
end

% Get values that give the higher return
[leadIndex, lagIndex] = find(fitness == max(max(fitness)));
leading = leadValues(leadIndex);
lagging = lagValues(lagIndex);

%profitLossSerie(stockQuotes, leadLagMovAvg(stockQuotes, lead, lag));

end
