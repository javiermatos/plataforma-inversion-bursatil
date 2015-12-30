
function tsobj = matrix2mfts(desc, freq, m)

tsobj = fints( ...
    m(:,1), ...         % Date
    [ ...               % Data values
        m(:,2), ...     % Open
        m(:,3), ...     % High
        m(:,4), ...     % Low
        m(:,5), ...     % Close
        m(:,6) ...      % Volume
    ], ...
    { ...               % Data names
        'open', ...
        'high', ...
        'low', ...
        'close', ...
        'volume' ...
    }, ...
    freq, ...           % Frecuency
    desc ...            % Symbol as description
    );

end
