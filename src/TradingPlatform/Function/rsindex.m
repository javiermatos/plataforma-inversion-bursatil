function rsi = rsindex(closep, nperiods)

% Calculate the Relative Strength index (RSI).
if (nperiods > 0)
    % Determine how many nans are in the beginning
    nanVals = isnan(closep);
    firstVal = find(nanVals == 0, 1, 'first');
    numLeadNans = firstVal - 1;

    % Create vector of non-nan closing prices
    nnanclosep = closep(~isnan(closep));

    % Take a diff of the non-nan closing prices
    diffdata = diff(nnanclosep);
    priceChange = abs(diffdata);

    % Create '+' Delta vectors and '-' Delta vectors
    advances = priceChange;
    declines = priceChange;

    advances(diffdata < 0) = 0;
    declines(diffdata >= 0) = 0;

    % Calculate the RSI of the non-nan closing prices. Ignore first non-nan
    % closep b/c it is a reference point. Take into account any leading nans
    % that may exist in closep vector.
    trsi = nan(1, length(diffdata)-numLeadNans);
    for didx = nperiods:length(diffdata)
        % Gains/losses
        totalGain = sum(advances((didx - (nperiods-1)):didx));
        totalLoss = sum(declines((didx - (nperiods-1)):didx));

        % Calculate RSI
        rs         = totalGain ./ totalLoss;
        trsi(didx) = 100 - (100 / (1+rs)); % [100 0] range
        %trsi(didx) = rs ./ (1+rs); % [1 0] range
    end

    % Pre allocate vector taking into account reference value and leading nans.
    % length of vector = length(closep) - # of reference values - # of leading nans
    rsi = nan(1, length(closep)-1-numLeadNans);

    % Populate rsi
    rsi(~isnan(closep(2+numLeadNans:end))) = trsi;

    % Add leading nans
    rsi = [nan(1, numLeadNans+1) rsi];

else
    error('nPeriods must be a greater than 0.');
end

end
