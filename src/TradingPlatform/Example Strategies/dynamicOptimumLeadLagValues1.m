
% Dynamic optimum lead/lag values
function [output, fitnessMatrix] = dynamicOptimumLeadLagValues1(stockQuotes, windowSize, jump, offset, values)

if max(values)>offset
    error('offset must be greather than max(values).');
end

S = length(stockQuotes);

index = offset:jump:S;


N = length(index)-1;

% startIndex = zeros(N,1);
% endIndex = zeros(N,1);
% leadValues = zeros(N,1);
% lagValues = zeros(N,1);

startIndex = [];
endIndex = [];
leadValues = [];
lagValues = [];

maxValue = max(values);

fitnessMatrix = zeros(length(values)-1,length(values),N);

% % Sliced space
% stockQuotesSlice = cell(N,1);
% for i = 1:N
%     stockQuotesSlice{i} = stockQuotes(index(i)-maxValue:min(index(i)+windowSize,S));
% end
% 
% parfor i = 1:N
% 
%     sIndex = index(i);
%     eIndex = min(index(i)+windowSize,S);
%     
%     [leadding, lagging] = optimumLeadLagValues( ...
%         stockQuotesSlice{i}, maxValue, values);
%     
%     fitnessMatrix(:,:,i) = fitness;
%     
%     startIndex = [ startIndex ; sIndex*ones(length(leadding),1) ];
%     endIndex = [ endIndex ; eIndex*ones(length(leadding),1) ];
%     leadValues = [ leadValues ; leadding ];
%     lagValues = [ lagValues ; lagging ];
%     
% end

% Not sliced space
for i = 1:N
    
    sIndex = index(i);
    eIndex = min(index(i)+windowSize,S);
    
    
    [leadding, lagging, fitness] = optimumLeadLagValues( ...
        stockQuotes(sIndex-maxValue:eIndex), maxValue, values);

    fitnessMatrix(:,:,i) = fitness;
    
    startIndex = [ startIndex ; sIndex*ones(length(leadding),1) ];
    endIndex = [ endIndex ; eIndex*ones(length(leadding),1) ];
    leadValues = [ leadValues ; leadding ];
    lagValues = [ lagValues ; lagging ];
    
end

output = [ startIndex endIndex leadValues lagValues ];

end
