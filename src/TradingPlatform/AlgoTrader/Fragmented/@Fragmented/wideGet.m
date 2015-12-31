
function values = wideGet(algoTrader, name)

%
N = length(algoTrader.Fragment);

% Allocate space
values = cell(1, N);

for i = 1:N
    
    values{i} = subsref( ...
                    algoTrader.Fragment(i), ...
                    struct( ...
                        'type','.', ...
                        'subs', name ...
                        ) ...
                    );
    
end

end
