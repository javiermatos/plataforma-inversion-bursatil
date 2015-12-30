
function m = mfts2matrix(tsobj)

m = [ ...
        getfield(tsobj, 'dates'), ...   % Date
        getfield(tsobj, 'open'), ...    % Open
        getfield(tsobj, 'high'), ...    % High
        getfield(tsobj, 'low'), ...     % Low
        getfield(tsobj, 'close'), ...   % Close
        getfield(tsobj, 'volume') ...   % Volume
    ];

end
