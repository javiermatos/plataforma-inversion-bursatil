
function pairs = leadLagPairs(values)

N = length(values);
pairs = cell(((N-1)*N)/2,1);

values = sort(values);

index = 1;
for i = 1:N-1
    
    for j = i+1:N
        
        pairs{index} = [values(i), values(j)];
        index = index + 1;
        
    end
    
end


end
