
function output = smoothness(input, fun, samples)

if ~exist('fun','var'); fun = @(i) ones(1,i); end
if ~exist('samples','var'); samples = 0; end

if samples == 1
    
    output = input;
    
elseif samples > 1
    
    weights = fun(samples);
    
    output = input;
    
    for i = 1:samples-1
        
        % Prevent division by 0
        divisor = sum(weights(1:i));
        if divisor ~= 0
            output(i) = sum(weights(1:i)/divisor.*input(1:i));
            %output(i) = sum(weights(1:i)/divisor.*output(1:i));
            
%             tmp = filter(fliplr(weights(1:i)), divisor, input(1:i));
%             output(i) = tmp(end);
        end
        
    end
    
    % Prevent division by 0
    divisor = sum(weights);
    if divisor ~= 0
        tmp = filter(fliplr(weights), divisor, input);
        %tmp = filter(fliplr(weights), divisor, output);
        
        output(samples:end) = tmp(samples:end);
        
    end
    
else
    
    error('samples must be greater than 0.');
    
end

end
