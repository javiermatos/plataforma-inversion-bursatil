
function vout = movavg(vin, mode, samples)

if samples > length(vin)
    error('Samples is greater than the length of the vector.');
end

% Mov Avg modes and calculations
switch lower(mode)
    case {'s', 'simple'} % Simple
        
        % Calculate simple mov avg
        vout = simplemovavg(vin, samples);
        
    case {'l', 'linear'} % Linear
        
        vout = NaN(size(vin));
        
        ma = filter((samples:-1:1)./((samples+1)*samples/2), 1, vin);
        
        vout(samples:end) = ma(samples:end);
        

    case {'e', 'exponential'} % Exponential
        
        % Calculate the exponential percentage
        k = 2/(samples+1);

        %
        % EMA = (k * (CurrentPrice-PreviousPeriodEMA)) / PreviousPeriodEMA
        % EMA = (k * (vin-vout)) / vout
        %     = K*vin + ((1-k) * vout)
        %

        % Calculate the simple moving average for the first 'exp mov avg'
        % value.
        vout = NaN(size(vin));
        vout(samples) = sum(vin(1:samples))/samples;

        % K*vin; 1-k
        kvin = vin(samples:end) * k;
        oneK = 1-k;

        % First period calculation
        vout(samples) = kvin(1)+(vout(samples)*oneK);

        % Remaining periods calculation
        for idx = samples+1:length(vin)
            vout(idx) = kvin(idx-samples+1)+(vout(idx-1)*oneK);
        end

    case {'t', 'triangular'} % Triangular

        % Window size
        samples = ceil((samples+1)/2);

        % First and Second moving average
        vout = simplemovavg(simplemovavg(vin, samples), samples);

    case {'w', 'heighted'} % Weighted
        
        % Samples must be a column vector
        samples = samples(:);
        
        % Length weights
        lenWghts = length(samples);
        
        % Sum of weights
        sumWghts = sum(samples);

        % Preallocate a vector of nans
        vout = NaN(size(vin));
        
        % Calculate the weighted mov avg
        for idx = lenWghts:length(vin)
            vout(idx) = sum(samples.*vin(idx-lenWghts+1:idx))/sumWghts;
        end

    case {'m', 'modified'} % Modified
        % Get the number of periods

        % Calculate simple mov avg. The first point of the modified moving
        % average is calculated the same way the first point of the simple
        % moving average is calculated. However, all subsequent points are
        % calculated using the modified mov avg formula.
        vout = simplemovavg(vin, samples);

        % Calculate modified mov avg
        for idx = samples+1:length(vin)
            % Remaining periods calculation
            vout(idx) = vout(idx-1)+(vin(idx)-vout(idx-1))/samples;
        end

    otherwise
        error('Invalid mode.');
end

end

function vout = simplemovavg(vin, samples)
% Simple moving average

vout = NaN(size(vin));

ma = filter(ones(1,samples)/samples, 1, vin);

vout(samples:end) = ma(samples:end);

end
